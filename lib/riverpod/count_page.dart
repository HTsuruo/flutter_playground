import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../logger.dart';

class CountPage extends ConsumerStatefulWidget {
  const CountPage({Key? key}) : super(key: key);

  static const routeName = '/count';

  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends ConsumerState<CountPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(countProvider).state = 0;
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
          children: const [
            _Count(),
            Gap(16),
            _DoubleCount(),
            Gap(16),
            _CountThreshold(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countProvider).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CountDisplay extends StatelessWidget {
  const _CountDisplay({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

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

final countProvider = StateProvider((ref) => 0);

class _Count extends ConsumerWidget {
  const _Count({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider).state;
    return _CountDisplay(
      label: 'count',
      value: count.toString(),
    );
  }
}

// カウントする度にダブルカウントを返すcounter
final doubleCountProvider = Provider(
  (ref) {
    logger.info('doubleCountProvider');
    final count = ref.watch(countProvider.select((s) => s.state));
    return count * 2;
  },
);

class _DoubleCount extends ConsumerWidget {
  const _DoubleCount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(doubleCountProvider);
    return _CountDisplay(
      label: 'double count',
      value: count.toString(),
    );
  }
}

// 5を超えると途中からカウントを始めるcounter
final thresholdProvider = Provider(
  (ref) {
    logger.info('isOverThreshold');
    // `select`の中でbool条件をいれると満たしていない場合を間引ける
    final isOverThreshold = ref.watch(
      countProvider.select((s) => s.state > 5 ? s.state : 0),
    );
    return isOverThreshold;
  },
);

class _CountThreshold extends ConsumerWidget {
  const _CountThreshold({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threshold = ref.watch(thresholdProvider);
    return _CountDisplay(
      label: 'threshold',
      value: threshold.toString(),
    );
  }
}
