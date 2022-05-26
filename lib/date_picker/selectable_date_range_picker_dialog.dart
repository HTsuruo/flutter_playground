import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'date_range_selector.dart';

class SelectableDateRangePickerDialog extends ConsumerWidget {
  const SelectableDateRangePickerDialog({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.currentDate,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? currentDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Column(
        children: [
          Expanded(
            child: Localizations.override(
              context: context,
              locale: const Locale('ja'),
              child: DateRangePickerDialog(
                firstDate: firstDate,
                lastDate: lastDate,
                currentDate: currentDate,
              ),
            ),
          ),
          const Divider(height: 0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 2,
            ),
            child: _DateRangeSelectButtons(),
          ),
        ],
      ),
    );
  }
}

class _DateRangeSelectButtons extends ConsumerWidget {
  const _DateRangeSelectButtons({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selector = ref.watch(dateRangeSelector.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          onPressed: selector.recently,
          child: const Text('14日間'),
        ),
        OutlinedButton(
          onPressed: selector.monthly,
          child: const Text('今月'),
        ),
        OutlinedButton(
          onPressed: selector.yearly,
          // style: OutlinedButton.styleFrom(
          //   visualDensity: VisualDensity.compact,
          // ),
          child: const Text('今年'),
        ),
      ],
    );
  }
}
