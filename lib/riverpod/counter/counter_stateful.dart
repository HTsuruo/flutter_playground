import 'package:flutter/material.dart';

/// RiverpodやProviderを全く使わないピュアなStatefulWidgetでのカウンター
/// 便利なパッケージを使うには元実装の課題を知ることが大事
class CounterStateful extends StatefulWidget {
  const CounterStateful({super.key});

  static const routeName = '/counter/stateful';

  @override
  State<CounterStateful> createState() => _CounterStatefulState();
}

class _CounterStatefulState extends State<CounterStateful> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
      ),
      body: Center(
        child: Text('count: $_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
      ),
    );
  }
}
