import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_02.g.dart';

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

class Counter02 extends ConsumerWidget {
  const Counter02({super.key});

  static const routeName = '/counter02';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter02'),
      ),
      body: Center(child: Text('count: ${ref.watch(counterProvider)}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
