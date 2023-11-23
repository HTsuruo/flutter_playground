// ignore_for_file: unreachable_from_main

import 'package:flutter/material.dart';
import 'package:flutter_playground/go_router_riverpod/authenticator.dart';
import 'package:flutter_playground/go_router_riverpod/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => ProgressHUD(child: child!),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _UriLocationText(),
            TextButton(
              child: const Text('Sign out'),
              onPressed: () {
                ref.read(authenticatorProvider.notifier).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SigninPage extends ConsumerWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _UriLocationText(),
            TextButton(
              child: const Text('Sign in'),
              onPressed: () {
                ref.read(authenticatorProvider.notifier).signIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UriLocationText(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _UriLocationText extends StatelessWidget {
  const _UriLocationText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(GoRouterState.of(context).uri.toString()),
    );
  }
}
