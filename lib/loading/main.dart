import 'package:flutter/material.dart';
import 'package:flutter_playground/loading/circular_progress_indicator_page.dart';
import 'package:flutter_playground/loading/shimmer_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsuruo_kit/widgets/playground_builder.dart';

void main() {
  return runApp(
    const ProviderScope(child: App()),
  );
}

// Change this for any sample pages.
String _title = 'Loading Sample';
Map<String, WidgetBuilder> _routes = {
  // 普通のCircularProgressIndicator
  CircularProgressIndicatorPage.routeName: (context) =>
      const CircularProgressIndicatorPage(),
  // Skeleton Screen
  ShimmerPage.routeName: (context) => const ShimmerPage(),
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
