import 'package:flutter/material.dart';
import 'package:flutter_playground/framework_practice//stateful_sample_page.dart';
import 'package:flutter_playground/framework_practice/stateless_sample_page.dart';
import 'package:flutter_playground/playground_builder.dart';

void main() {
  return runApp(const App());
}

// Change this for any sample pages.
String _title = 'Key Practice';
Map<String, WidgetBuilder> _routes = {
  StatelessSamplePage.routeName: (context) => const StatelessSamplePage(),
  StatefulSamplePage.routeName: (context) => const StatefulSamplePage(),
};

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: PlaygroundBuilder(
        title: _title,
        routes: _routes,
      ),
      routes: _routes,
    );
  }
}
