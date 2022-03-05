import 'package:flutter/material.dart';
import 'package:flutter_playground/paging/paging_page.dart';
import 'package:flutter_playground/paging/paging_stateful_page.dart';
import 'package:flutter_playground/playground_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
  PagingPage.routeName: (context) => const PagingPage(),
  PagingStatefulPage.routeName: (context) => const PagingStatefulPage(),
};

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
      ),
      home: PlaygroundBuilder(
        title: 'Paging',
        routes: _routes,
      ),
    );
  }
}
