import 'package:flutter/material.dart';
import 'package:flutter_playground/riverpod/controller_pattern/sample_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsumerScopedPage extends StatelessWidget {
  const ConsumerScopedPage({Key? key}) : super(key: key);
  static const routeName = '/consumer_scoped';

  // WidgetRef: widget層でproviderとやりとりができるObject
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.runtimeType.toString(),
        ),
      ),
      // この小さいスコープで閉じることも可能
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            // providerとやりとりができる
            ref.read(sampleProvider).doSomething();
          },
          child: const Icon(Icons.add),
        );
      },),
    );
  }
}
