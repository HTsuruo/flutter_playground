import 'package:flutter/material.dart';
import 'package:flutter_playground/stream/state_provider_sample/state_provider_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderNextPage extends ConsumerWidget {
  const StateProviderNextPage({super.key});

  static const routeName = '/state_provider_next';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(stateProviderController);
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
    );
  }
}
