import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/enum_segmented_control/fruit_tab_type_controller.dart';
import 'package:flutter_playground/enum_segmented_control/fruit_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FruitTabType extends ConsumerWidget {
  const FruitTabType({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fruit = ref.watch(fruitTabTypeController);
    final map = Map.fromEntries(
      FruitType.values.map(
        (type) {
          final isSelected = type == fruit;
          return MapEntry(
            type,
            Text(
              type.label,
              style: theme.textTheme.bodyText2!.copyWith(
                fontWeight: isSelected ? FontWeight.bold : null,
                color: isSelected ? colorScheme.onPrimary : null,
              ),
            ),
          );
        },
      ),
    );
    return CupertinoSlidingSegmentedControl<FruitType>(
      children: map,
      onValueChanged: (value) {
        ref.read(fruitTabTypeController.notifier).select(value!);
      },
      thumbColor: colorScheme.primary,
      groupValue: fruit,
    );
  }
}
