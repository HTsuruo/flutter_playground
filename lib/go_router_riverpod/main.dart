// ignore_for_file: unreachable_from_main

import 'package:flutter/material.dart';
import 'package:flutter_playground/go_router_riverpod/authenticator.dart';
import 'package:flutter_playground/go_router_riverpod/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Sign out'),
          onPressed: () {
            ref.read(authenticatorProvider.notifier).signOut();
          },
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
        child: TextButton(
          child: const Text('Sign in'),
          onPressed: () {
            ref.read(authenticatorProvider.notifier).signIn();
          },
        ),
      ),
    );
  }
}
