import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_playground/stream/state_provider_sample/state_provider_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StateProviderNextPage extends HookWidget {
  const StateProviderNextPage({Key? key}) : super(key: key);

  static const routeName = '/state_provider_next';

  @override
  Widget build(BuildContext context) {
    useProvider(stateProviderController);
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
    );
  }
}
