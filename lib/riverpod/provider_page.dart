import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderPage extends ConsumerWidget {
  const ProviderPage({Key? key}) : super(key: key);

  static const routeName = '/provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample'),
      ),
      body: const Center(
        child: Text('counter:'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
