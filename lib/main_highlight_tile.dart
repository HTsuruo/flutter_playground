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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HighlightTile'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return HighlightTile(
            enabled: index == 2,
            child: _Tile(label: 'index: ${index + 1}'),
          );
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: const Text('this is subtitle'),
      onTap: () {},
    );
  }
}

class HighlightTile extends StatefulWidget {
  const HighlightTile({
    super.key,
    required this.child,
    this.highlightColor,
    this.enabled = true,
  });

  final Widget child;
  final Color? highlightColor;
  final bool enabled;

  @override
  State<HighlightTile> createState() => _HighlightTileState();
}

class _HighlightTileState extends State<HighlightTile>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<Decoration> _animation = _animationController.drive(
    DecorationTween(
      begin: const BoxDecoration(),
      end: BoxDecoration(color: widget.highlightColor ?? Colors.amber),
    ),
  );

  @override
  void initState() {
    if (!widget.enabled) {
      _animationController.dispose();
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await _animationController.reverse();
      }
    });
    super.initState();
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
