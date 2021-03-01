import 'package:flutter/material.dart';
import 'package:flutter_playground/framework_practice//stateful_sample_page.dart';
import 'package:flutter_playground/framework_practice/stateless_sample_page.dart';
import 'package:flutter_playground/tiles.dart';
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

// Change this for any sample pages.
String _title = 'Key Practice';
Map<String, WidgetBuilder> _routes = {
  StatelessSamplePage.routeName: (context) => const StatelessSamplePage(),
  StatefulSamplePage.routeName: (context) => const StatefulSamplePage(),
};

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
      home: Builder(
        builder: (context) => Tiles(
          title: _title,
          tiles: _routes.entries
              .map(
                (route) => ListTile(
                  title: Text(route.key),
                  onTap: () => Navigator.of(context).pushNamed(route.key),
                ),
              )
              .toList(),
        ),
      ),
      routes: _routes,
    );
  }
}