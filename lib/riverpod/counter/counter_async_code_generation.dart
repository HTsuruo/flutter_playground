import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_async_code_generation.g.dart';

/// AsyncNotifierのcode generateサンプル
/// デフォルトではAutoDisposeなProviderで生成される
/// buildメソッドの返却を`FutureOr`とするとよしなにAsyncNotifierで自動生成される
@riverpod
class Counter extends _$Counter {
  @override
  FutureOr<int> build() async {
    // buildメソッドで初期値をセットする
    logger.info('build');
    await Future<void>.delayed(const Duration(seconds: 2));
    logger.info('1 delayed');
    return Future.value(0);
  }

  void increment() {
    state = AsyncData(state.value! + 1);
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
