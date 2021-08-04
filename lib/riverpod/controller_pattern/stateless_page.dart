import 'package:flutter/material.dart';
import 'package:flutter_playground/riverpod/controller_pattern/sample_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatelessPage extends ConsumerWidget {
  const StatelessPage({Key? key}) : super(key: key);
  static const routeName = '/stateless';

  // WidgetRef: widget層でproviderとやりとりができるObject
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.runtimeType.toString(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // providerとやりとりができる
          ref.read(sampleProvider).doSomething();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
