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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<Decoration> _animation = _animationController.drive(
    DecorationTween(
      begin: const BoxDecoration(color: Colors.transparent),
      end: const BoxDecoration(color: Colors.amber),
    ),
  );

  @override
  void initState() {
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('HighlightTile'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return index.isEven
              ? DecoratedBoxTransition(
                  decoration: _animation,
                  child: _Tile(label: '${index + 1}'),
                )
              : _Tile(label: '${index + 1}');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animationController.forward,
        child: const Icon(Icons.add),
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
