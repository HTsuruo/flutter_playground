import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const _SamplePage(),
    );
  }
}

class _SamplePage extends StatefulWidget {
  const _SamplePage();

  @override
  State<_SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<_SamplePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SamplePage'),
      ),
      body: Center(
        child: SmoothHighlight(
          // MEMO(tsuruoka): 初回のみしかアニメーションは聞かないのでkeyを変えて別インスタンスとして生成する必要がある
          key: ValueKey(_counter),
          child: const Text('text'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmoothHighlight'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) {
          final target = index == 2;
          return SmoothHighlight(
            enabled: target,
            child: ListTile(
              title: Text('index: ${index + 1}'),
              subtitle: Text(target ? 'highlight tile' : 'normal tile'),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class SmoothHighlight extends StatefulWidget {
  const SmoothHighlight({
    super.key,
    required this.child,
    this.highlightColor,
    this.enabled = true,
  });

  final Widget child;
  final Color? highlightColor;
  final bool enabled;

  @override
  State<SmoothHighlight> createState() => _SmoothHighlightState();
}

class _SmoothHighlightState extends State<SmoothHighlight>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<Decoration> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation = _animationController
        .drive(
          CurveTween(curve: Curves.easeInOut),
        )
        .drive(
          DecorationTween(
            begin: const BoxDecoration(),
            end: BoxDecoration(
              color: widget.highlightColor ?? Theme.of(context).primaryColor,
            ),
          ),
        );
    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.enabled
        ? DecoratedBoxTransition(
            decoration: _animation,
            child: widget.child,
          )
        : widget.child;
  }
}
