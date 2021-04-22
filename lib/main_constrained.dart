import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 320, minHeight: 64),
            child: Container(
              color: Colors.red,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 160, minHeight: 64),
            child: Container(
              color: Colors.red,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 64),
            child: Container(color: Colors.green),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(width: 320, height: 64),
            child: Container(
              color: Colors.blue,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.loose(const Size(640, 64)),
            child: Container(
              color: Colors.grey,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(320, 64)),
            child: Container(
              color: Colors.red,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 64),
            child: Container(
              color: Colors.green,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 320, minHeight: 64),
            child: Container(
              color: Colors.blue,
              child: const Text('おまけ'),
            ),
          ),
        ],
      ),
    );
  }
}
