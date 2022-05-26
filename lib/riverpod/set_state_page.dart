import 'package:flutter/material.dart';

class SetStatePage extends StatefulWidget {
  const SetStatePage({super.key});

  static const routeName = '/set_state';

  @override
  _SetStatePageState createState() => _SetStatePageState();
}

class _SetStatePageState extends State<SetStatePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample'),
      ),
      body: Center(
        child: Text('counter:$_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
