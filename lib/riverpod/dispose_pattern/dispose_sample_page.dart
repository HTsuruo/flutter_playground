import 'package:flutter/material.dart';
import 'package:flutter_playground/riverpod/dispose_pattern/dispose_sample_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisposeSamplePage extends ConsumerWidget {
  const DisposeSamplePage({super.key});

  static const routeName = '/dispose_sample_page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(disposeSampleController);
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Text(
        runtimeType.toString(),
      ),
    );
  }
}
