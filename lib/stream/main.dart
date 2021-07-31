import 'package:flutter/material.dart';
import 'package:flutter_playground/stream/state_provider_sample/state_provider_next_page.dart';
import 'package:flutter_playground/stream/state_provider_sample/state_provider_page.dart';
import 'package:flutter_playground/stream/stream_sample_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

import '../logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
  return runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

// Change this for any sample pages.
String _title = 'Stream Sample Page';
Map<String, WidgetBuilder> _routes = {
  StreamSamplePage.routeName: (context) => const StreamSamplePage(),
  StateProviderPage.routeName: (context) => const StateProviderPage(),
  StateProviderNextPage.routeName: (context) => const StateProviderNextPage(),
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
