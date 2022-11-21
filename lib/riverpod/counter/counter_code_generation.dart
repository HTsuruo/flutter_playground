import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_code_generation.g.dart';

/// Notifierのcode generateサンプル
/// デフォルトではAutoDisposeなProviderで生成される
/// ref. https://github.com/rrousselGit/riverpod/tree/master/packages/riverpod_generator
@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    logger.info('build');
    return 0;
  }

  void increment() {
    state++;
  }
}

class CounterCodeGeneration extends ConsumerWidget {
  const CounterCodeGeneration({super.key});

  static const routeName = '/counter/code_generation';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code generation'),
      ),
      body: Center(child: Text('count: ${ref.watch(counterProvider)}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
