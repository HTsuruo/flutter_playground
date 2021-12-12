import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('list'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/detail'),
          child: const Text('Navigate to Detail'),
        ),
      ),
    );
  }
}
