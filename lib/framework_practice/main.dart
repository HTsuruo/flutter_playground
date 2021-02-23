import 'package:flutter/material.dart';
import 'package:flutter_playground/framework_practice//stateful_sample_page.dart';
import 'package:flutter_playground/framework_practice/stateless_sample_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

import '../logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
  return runApp(
    const ProviderScope(
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const _ListPage(),
      routes: {
        StatelessSamplePage.routeName: (context) => const StatelessSamplePage(),
        StatefulSamplePage.routeName: (context) => const StatefulSamplePage(),
      },
    );
  }
}

class _ListPage extends StatelessWidget {
  const _ListPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ListTile> _tiles() {
      return [
        ListTile(
          title: const Text(StatelessSamplePage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(StatelessSamplePage.routeName),
        ),
        ListTile(
          title: const Text(StatefulSamplePage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(StatefulSamplePage.routeName),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Practice'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => _tiles()[index],
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _tiles().length,
      ),
    );
  }
}
