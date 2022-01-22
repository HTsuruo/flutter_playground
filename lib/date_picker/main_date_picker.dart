import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_playground/date_picker/selectable_date_range_picker_dialog.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ],
  // );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
    );
  }
}

final firstDate = DateTime(2022, 1);
final currentDate = DateTime.now();
final lastDate = currentDate.add(const Duration(days: 360));
const locale = Locale('ja');

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const divider = Divider();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('showDatePicker'),
            subtitle: const Text('スタンダードな日付選択方法'),
            onTap: () async {
              final selected = await showDatePicker(
                context: context,
                firstDate: firstDate,
                lastDate: lastDate,
                initialDate: currentDate,
                locale: locale,
              );
              logger.info('selected: $selected');
            },
          ),
          divider,
          ListTile(
            title: const Text('showDatePicker - calender only'),
            subtitle: const Text('カレンダーのみ（入力不要）なパターン'),
            onTap: () async {
              final selected = await showDatePicker(
                context: context,
                firstDate: firstDate,
                lastDate: lastDate,
                initialDate: currentDate,
                locale: locale,
                // カレンダーのみ指定もできる（入力が不要な場合）
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              );
              logger.info('selected: $selected');
            },
          ),
          divider,
          // ref. https://api.flutter.dev/flutter/material/showDateRangePicker.html
          ListTile(
            title: const Text('showDateRangePicker'),
            subtitle: const Text('スタンダードな期間選択方法'),
            onTap: () async {
              final datetimeRange = await showDateRangePicker(
                context: context,
                firstDate: firstDate,
                lastDate: lastDate,
                currentDate: currentDate,
                locale: locale,
                // カレンダーのみ指定も可
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              );
              logger.info(
                'start: ${datetimeRange?.start}, end: ${datetimeRange?.end}',
              );
            },
          ),
          divider,
          // ref. https://api.flutter.dev/flutter/material/DateRangePickerDialog-class.html
          ListTile(
            title: const Text('DateRangePicker - showModalBottomSheet'),
            subtitle: const Text('通常フルスクリーンな期間選択をモーダルシートで呼び出したパターン'),
            onTap: () async {
              final datetimeRange = await showModalBottomSheet<DateTimeRange?>(
                context: context,
                builder: (_) => const _LocalizedDateRangePickerDialog(),
              );
              logger.info(
                'start: ${datetimeRange?.start}, end: ${datetimeRange?.end}',
              );
            },
          ),
          divider,
          // ref. https://api.flutter.dev/flutter/material/DateRangePickerDialog-class.html
          ListTile(
            title: const Text('DateRangePicker + some widget'),
            subtitle: const Text('任意のWidgetを組み合わせた場合'),
            onTap: () async {
              final datetimeRange = await showModalBottomSheet<DateTimeRange?>(
                context: context,
                builder: (context) {
                  return SelectableDateRangePickerDialog(
                    firstDate: firstDate,
                    lastDate: lastDate,
                    currentDate: currentDate,
                  );
                },
              );
              logger.info(
                'start: ${datetimeRange?.start}, end: ${datetimeRange?.end}',
              );
            },
          ),
          divider,
          // ref. https://api.flutter.dev/flutter/material/DateRangePickerDialog-class.html
          ListTile(
            title: const Text('DateRangePicker + showCupertinoDialog'),
            subtitle: const Text('任意のWidgetを組み合わせた場合'),
            onTap: () async {
              final datetimeRange =
                  await showCupertinoModalBottomSheet<DateTimeRange?>(
                context: context,
                builder: (context) {
                  return SelectableDateRangePickerDialog(
                    firstDate: firstDate,
                    lastDate: lastDate,
                    currentDate: currentDate,
                  );
                },
              );
              logger.info(
                'start: ${datetimeRange?.start}, end: ${datetimeRange?.end}',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LocalizedDateRangePickerDialog extends StatelessWidget {
  const _LocalizedDateRangePickerDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // localを指定する場合はshowDateRangePickerの実装を参考に
    // Localizations.overrideで包むと再現できる。
    return Localizations.override(
      context: context,
      locale: locale,
      child: DateRangePickerDialog(
        firstDate: firstDate,
        lastDate: lastDate,
        currentDate: currentDate,
        // カレンダーのみ指定も可
        initialEntryMode: DatePickerEntryMode.calendarOnly,
      ),
    );
  }
}
