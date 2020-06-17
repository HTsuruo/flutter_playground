import 'package:flutter/material.dart';
import 'package:flutter_playground/transition_sample/detail.dart';

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
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text('画面遷移'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<PageRoute>(
                  builder: (context) => const Detail(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
