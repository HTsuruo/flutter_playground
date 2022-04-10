import 'package:flutter/material.dart';
import 'package:flutter_playground/loading/future_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircularProgressIndicatorPage extends ConsumerWidget {
  const CircularProgressIndicatorPage({Key? key}) : super(key: key);

  static const routeName = '/loading/circular_progress_indicator';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureMock).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ListTile(
                  title: Text(value),
                )
              ],
            ),
    );
  }
}
