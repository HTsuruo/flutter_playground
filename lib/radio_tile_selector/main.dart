import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/radio_tile_selector/enum.dart';
import 'package:flutter_playground/radio_tile_selector/radio_tile_sheet.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final res = await showRadioSelector<SampleType>(
                  context: context,
                  initialValue: SampleType.hoge,
                  data: SampleType.values
                      .map(
                        (e) => RadioParam(title: e.label, value: e),
                      )
                      .toList(),
                );
                if (res == null) {
                  return;
                }
                logger.info(res);
              },
              child: const Text('show'),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await showRadioSelector<HogeType>(
                  context: context,
                  initialValue: HogeType.hoge1,
                  data: HogeType.values
                      .map(
                        (e) => RadioParam(title: e.label, value: e),
                      )
                      .toList(),
                );
                if (res == null) {
                  return;
                }
                logger.info(res);
              },
              child: const Text('show'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showRadioSelector<T>({
  required BuildContext context,
  required T initialValue,
  required List<RadioParam<T>> data,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) => RadioTileSheet2<T>(
      initialValue: initialValue,
      data: data,
    ),
  );
}
