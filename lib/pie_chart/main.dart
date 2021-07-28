import 'package:flutter/material.dart';
import 'package:flutter_playground/pie_chart/fl_chart_pie_chart_page.dart';
import 'package:flutter_playground/tiles.dart';

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
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      // 下記エラー回避のためBuilderで包んだ
      // Navigator operation requested with
      // a context that does not include a Navigator.
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
