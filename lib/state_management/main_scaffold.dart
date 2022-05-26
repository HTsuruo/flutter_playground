import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.title,
    required this.counter,
    required this.onPressed,
  });

  final String title;
  final int counter;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('counter: $counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
