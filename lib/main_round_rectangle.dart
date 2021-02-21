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
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('RoundedRectangleBorder'),
                      Text('R（16）'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('ContinuousRectangleBorder'),
                      Text('R（16）'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('RoundedRectangleBorder'),
                      Text('R（50）'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('ContinuousRectangleBorder'),
                      Text('R（50）'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
