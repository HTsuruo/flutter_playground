import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class Hoge {
  Hoge(this.key, this.value);
  String key;
  double value;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = [
      Hoge('1', 1),
      Hoge('1', 1),
      Hoge('2', 2),
      Hoge('2', 1),
      Hoge('3', 3),
      Hoge('3', 4),
      Hoge('4', 4),
    ];

    final grouped = list.groupBy((e) => e.key);
    logger.fine(grouped);

    final sum = grouped.entries.map((e) {
      final s = e.value.sumBy((e) => e.value);
      return s;
    }).toList();
    logger.fine(sum);

    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('tsuruoka'),
      ),
    );
  }
}
