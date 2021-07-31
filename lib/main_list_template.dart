import 'package:flutter/material.dart';
import 'package:tsuruo_kit/widgets/playground_builder.dart';

void main() {
  return runApp(const App());
}

// Change this for any sample pages.
String _title = 'Stream Sample Page';
Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
};

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
