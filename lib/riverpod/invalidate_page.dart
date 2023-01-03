import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvalidatePage extends ConsumerWidget {
  const InvalidatePage({super.key});

  static const routeName = '/invalidate';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invalidate'),
      ),
      body: const Center(
        child: Text('text'),
      ),
    );
  }
}
