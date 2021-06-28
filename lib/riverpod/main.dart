import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/riverpod/change_notifer_page.dart';
import 'package:flutter_playground/riverpod/controller_pattern/consumer_scopoed_page.dart';
import 'package:flutter_playground/riverpod/controller_pattern/stateless_page.dart';
import 'package:flutter_playground/riverpod/inherited_widget_page.dart';
import 'package:flutter_playground/riverpod/provider_page.dart';
import 'package:flutter_playground/riverpod/set_state_page.dart';
import 'package:flutter_playground/riverpod/state_notifier_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

import '../tiles.dart';

void main() {
  logger.setLevel(Level.INFO, includeCallerInfo: true);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

// Change this for any sample pages.
String _title = 'Riverpod Sample Page';
Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
  StateNotifierPage.routeName: (context) => const StateNotifierPage(),
  ChangeNotifierPage.routeName: (context) => const ChangeNotifierPage(),
  StatelessPage.routeName: (context) => const StatelessPage(),
  ConsumerScopedPage.routeName: (context) => const ConsumerScopedPage(),
  ProviderPage.routeName: (context) => const ProviderPage(),
  InheritedWidgetPage.routeName: (context) => const InheritedWidgetPage(),
  SetStatePage.routeName: (context) => const SetStatePage(),
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
