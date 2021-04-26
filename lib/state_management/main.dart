import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/state_management/ex1_set_state_page.dart';
import 'package:flutter_playground/state_management/ex2_inherited_widget_page.dart';
import 'package:flutter_playground/tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
  return runApp(
    const ProviderScope(
      child: const App(),
    ),
  );
}

// Change this for any sample pages.
String _title = 'state management';
Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
  Ex1SetStatePage.routeName: (context) => const Ex1SetStatePage(),
  Ex2InheritedWidgetPage.routeName: (context) => const Ex2InheritedWidgetPage(),
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
