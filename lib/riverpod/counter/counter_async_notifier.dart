import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifierクラスのサンプル
/// ref. https://github.com/rrousselGit/riverpod/blob/master/packages/riverpod/lib/src/notifier/base.dart
final counterProvider = AsyncNotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);

// わざわざ明示的にRefクラスをProviderから渡さなくてもNotiferクラスの継承元NotiferBaseクラスが
// Refを持っているのでそのまま参照することができる。
class CounterNotifier extends AsyncNotifier<int> {
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

class CounterAsyncNotifierPage extends ConsumerWidget {
  const CounterAsyncNotifierPage({super.key});

  static const routeName = '/counter/async_notifier';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncNotifier'),
      ),
      body: Center(
        child: ref.watch(counterProvider).when(
              loading: CircularProgressIndicator.new,
              data: (count) => Text('count: $count'),
              error: (error, stackTrace) => Text(error.toString()),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
