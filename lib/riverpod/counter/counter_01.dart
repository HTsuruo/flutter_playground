import 'package:flutter/material.dart';

/// RiverpodやProviderを全く使わないピュアなStatefulWidgetでのカウンター
/// 便利なパッケージを使うには元実装の課題を知ることが大事
class Counter01 extends StatefulWidget {
  const Counter01({super.key});

  static const routeName = '/counter01';

  @override
  State<Counter01> createState() => _Counter01State();
}

class _Counter01State extends State<Counter01> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter01'),
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
