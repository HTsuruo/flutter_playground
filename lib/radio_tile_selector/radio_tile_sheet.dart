import 'package:flutter/material.dart';
import 'package:flutter_playground/radio_tile_selector/enum.dart';
import 'package:flutter_playground/radio_tile_selector/radio_tile_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'modal_sheet_container.dart';

final radioTileSheet = ChangeNotifierProvider.autoDispose(
  (ref) => RadioTileSelector<SampleType>(),
);

class RadioTileSheet extends ConsumerWidget {
  const RadioTileSheet({
    super.key,
    this.title = 'サンプル',
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selector = ref.watch(radioTileSheet);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ModalSheetContainer(
      title: title,
      child: Column(
        children: SampleType.values
            .map(
              (value) => RadioListTile<SampleType>(
                title: Text(
                  value.label,
                  style: theme.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: value,
                groupValue: selector.groupValue,
                activeColor: colorScheme.primary,
                onChanged: (value) => selector.onChange(
                  context,
                  value: value!,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

@immutable
class RadioParam<T> {
  const RadioParam({
    required this.title,
    required this.value,
    this.subTitle,
  });

  final String title;
  final String? subTitle;
  final T value;
}

class RadioTileSheet2<T> extends StatefulWidget {
  const RadioTileSheet2({
    super.key,
    this.title = 'サンプル',
    required this.initialValue,
    required this.data,
  });

  final String title;
  final T initialValue;
  final List<RadioParam<T>> data;

  @override
  _RadioTileSheet2State<T> createState() => _RadioTileSheet2State<T>();
}

class _RadioTileSheet2State<T> extends State<RadioTileSheet2<T>> {
  late T groupValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ModalSheetContainer(
      title: widget.title,
      child: Column(
        children: widget.data
            .map(
              (value) => RadioListTile<T>(
                title: Text(
                  value.title,
                  style: theme.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: value.subTitle == null ? null : Text(value.subTitle!),
                value: value.value,
                groupValue: groupValue,
                activeColor: colorScheme.primary,
                onChanged: (value) async {
                  setState(
                    () {
                      if (value != null) {
                        groupValue = value;
                      }
                    },
                  );
                  await Future<void>.delayed(const Duration(milliseconds: 300));
                  Navigator.pop(context, value);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
