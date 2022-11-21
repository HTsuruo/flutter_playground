import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/playground_builder.dart';
import 'package:flutter_playground/riverpod/change_notifer_page.dart';
import 'package:flutter_playground/riverpod/controller_pattern/consumer_scopoed_page.dart';
import 'package:flutter_playground/riverpod/controller_pattern/stateless_page.dart';
import 'package:flutter_playground/riverpod/counter/counter_01.dart';
import 'package:flutter_playground/riverpod/counter/counter_02.dart';
import 'package:flutter_playground/riverpod/counter/counter_03.dart';
import 'package:flutter_playground/riverpod/dispose_pattern/dispose_sample_page.dart';
import 'package:flutter_playground/riverpod/future/future_provider_page.dart';
import 'package:flutter_playground/riverpod/inherited_widget_page.dart';
import 'package:flutter_playground/riverpod/provider_page.dart';
import 'package:flutter_playground/riverpod/set_state_page.dart';
import 'package:flutter_playground/riverpod/state_notifier_page.dart';
import 'package:flutter_playground/riverpod/transform_provider_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

void main() {
  logger.setLevel(Level.INFO, includeCallerInfo: true);
  runApp(
    const ProviderScope(child: App()),
  );
}

// Change this for any sample pages.
String _title = 'Riverpod Example';
Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
  Counter01.routeName: (context) => const Counter01(),
  Counter02.routeName: (context) => const Counter02(),
  Counter03.routeName: (context) => const Counter03(),
  StateNotifierPage.routeName: (context) => const StateNotifierPage(),
  ChangeNotifierPage.routeName: (context) => const ChangeNotifierPage(),
  StatelessPage.routeName: (context) => const StatelessPage(),
  FutureProviderPage.routeName: (context) => const FutureProviderPage(),
  ConsumerScopedPage.routeName: (context) => const ConsumerScopedPage(),
  ProviderPage.routeName: (context) => const ProviderPage(),
  InheritedWidgetPage.routeName: (context) => const InheritedWidgetPage(),
  SetStatePage.routeName: (context) => const SetStatePage(),
  DisposeSamplePage.routeName: (context) => const DisposeSamplePage(),
  TransformProviderPage.routeName: (context) => const TransformProviderPage(),
};

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
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
