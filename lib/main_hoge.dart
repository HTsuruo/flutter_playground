import 'package:flutter/material.dart';

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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('tsuruoka'),
      ),
    );
  }
}

class ExpansionMessage extends StatefulWidget {
  const ExpansionMessage({super.key});

  @override
  State<ExpansionMessage> createState() => _ExpansionMessageState();
}

class _ExpansionMessageState extends State<ExpansionMessage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
