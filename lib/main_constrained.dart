import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 320.0, minHeight: 64.0),
            child: Container(
              color: Colors.red,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 160.0, minHeight: 64.0),
            child: Container(
              color: Colors.red,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 64.0),
            child: Container(color: Colors.green),
          ),
          ConstrainedBox(
            constraints:
                const BoxConstraints.expand(width: 320.0, height: 64.0),
            child: Container(
              color: Colors.blue,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.loose(Size(640.0, 64.0)),
            child: Container(
              color: Colors.grey,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(320.0, 64.0)),
            child: Container(
              color: Colors.red,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 64.0),
            child: Container(
              color: Colors.green,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 320.0, minHeight: 64.0),
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
