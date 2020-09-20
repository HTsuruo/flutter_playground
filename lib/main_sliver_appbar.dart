import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const _SliverCustom();
  }
}

class _SliverDefault extends StatelessWidget {
  const _SliverDefault({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Sliver Demo',
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ListTile(
                    title: Text('${index + 1}'),
                  ),
                  const Divider(),
                ],
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverCustom extends StatelessWidget {
  const _SliverCustom({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Available seats'),
            ),
            expandedHeight: 200,
            floating: false,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ListTile(
                    title: Text('${index + 1}'),
                  ),
                  const Divider(),
                ],
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
