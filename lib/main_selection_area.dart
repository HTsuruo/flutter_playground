import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const SelectionArea(
        child: HomePage(),
      ),
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
              onPressed: () {},
              child: const Text('Button'),
            ),
            const Gap(40),
            const Text('Text'),
          ],
        ),
      ),
    );
  }
}
