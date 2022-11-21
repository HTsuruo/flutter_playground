import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../logger.dart';

/// Providerチェーンの例
final countProvider = NotifierProvider<CountNotifier, int>(CountNotifier.new);

class CountNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}

// カウントする度にダブルカウントを返すcounter
final doubleCountProvider = Provider(
  (ref) {
    logger.info('doubleCountProvider');
    final count = ref.watch(countProvider);
    return count * 2;
  },
);

// 5を超えると途中からカウントを始めるcounter
final thresholdProvider = Provider(
  (ref) {
    logger.info('isOverThreshold');
    // `select`の中でbool条件をいれると満たしていない場合を間引ける
    final isOverThreshold = ref.watch(
      countProvider.select<int>((s) => s > 5 ? s : 0),
    );
    return isOverThreshold;
  },
);

class Counter04 extends ConsumerWidget {
  const Counter04({super.key});

  static const routeName = '/counter04';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter04'),
        actions: [
          TextButton(
            onPressed: () {
              // StateProviderの書き方
              // ref.read(countProvider.notifier).state = 0;
              // ref.read(countProvider.notifier).update((_) => 0);
              ref.read(countProvider.notifier).increment();
            },
            child: Text(
              'Reset',
              style: TextStyle(
                color: colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Count(),
            const Gap(16),
            const _DoubleCount(),
            const Gap(16),
            const _CountIfOverThreshold(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Count extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    return _CountDisplay(
      label: 'count',
      value: count.toString(),
    );
  }
}

class _DoubleCount extends ConsumerWidget {
  const _DoubleCount();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(doubleCountProvider);
    return _CountDisplay(
      label: 'double count',
      value: count.toString(),
    );
  }
}

class _CountIfOverThreshold extends ConsumerWidget {
  const _CountIfOverThreshold();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threshold = ref.watch(thresholdProvider);
    return _CountDisplay(
      label: 'threshold',
      value: threshold.toString(),
    );
  }
}

class _CountDisplay extends StatelessWidget {
  const _CountDisplay({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.bodyText1;
    return Column(
      children: [
        Text(
          label,
          style: textStyle,
        ),
        const Gap(4),
        Text(
          value,
          style: textStyle!.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
