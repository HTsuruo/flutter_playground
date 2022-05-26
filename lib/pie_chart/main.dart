import 'package:flutter/material.dart';
import 'package:flutter_playground/pie_chart/fl_chart_pie_chart_page.dart';
import 'package:flutter_playground/playground_builder.dart';

void main() {
  return runApp(const App());
}

// Change this for any sample pages.
String _title = 'Pie Chart Page';
Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
  FlChartPieChartPage.routeName: (context) => const FlChartPieChartPage(),
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
