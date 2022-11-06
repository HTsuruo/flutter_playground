import 'package:flutter/material.dart';
import 'package:flutter_playground/go_router/detail_page.dart';
import 'package:flutter_playground/go_router/list_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const App(),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const ListPage(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => const DetailPage(),
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouter Example: Declarative Routes',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () => context.go('/list'),
              child: const Text('Navigate to List'),
            ),
            OutlinedButton(
              onPressed: () => context.go('/detail'),
              child: const Text('Navigate to Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
