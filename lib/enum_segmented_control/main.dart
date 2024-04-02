import 'package:flutter/material.dart';
import 'package:flutter_playground/enum_segmented_control/fruit_tab_type.dart';
import 'package:flutter_playground/enum_segmented_control/fruit_tab_type_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fruit_type.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFruit = ref.watch(fruitTabTypeController);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enum Segmented Control Sample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FruitTabType(),
            Text('selected: ${selectedFruit.label}'),
          ],
        ),
      ),
    );
  }
}
