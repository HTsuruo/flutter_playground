import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifierクラスのサンプル
/// ref. https://github.com/rrousselGit/riverpod/blob/master/packages/riverpod/lib/src/notifier/base.dart
final counterProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);

// わざわざ明示的にRefクラスをProviderから渡さなくてもNotiferクラスの継承元NotiferBaseクラスが
// Refを持っているのでそのまま参照することができる。
class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    // buildメソッドで初期値をセットする
    logger.info('build');
    return 0;
  }

  void increment() {
    state++;
  }
}

class Counter01 extends ConsumerWidget {
  const Counter01({super.key});

  static const routeName = '/counter01';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter01'),
      ),
      body: Center(child: Text('count: ${ref.watch(counterProvider)}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
