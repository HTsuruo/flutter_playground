import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final sampleStateNotifierProvider =
    StateNotifierProvider.family.autoDispose<SampleController, int>(
  (ref, value) => SampleController(value: value),
);

class SampleController extends StateNotifier<int> {
  SampleController({this.value}) : super(0) {
    _init();
  }

  final int value;

  void increment() {
    print('increment');
    state++;
  }

  void _init() {
    print('init');
    print('value is $value');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}

class StateNotifierPage extends HookWidget {
  const StateNotifierPage({Key key}) : super(key: key);

  static const routeName = '/state_notifier';

  @override
  Widget build(BuildContext context) {
//    final state = useProvider(sampleStateNotifierProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifier'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('state notifier sample'),
        ),
      ),
      floatingActionButton: const _FabUserProviderPattern(),
//      floatingActionButton: const _FabContextPattern(),
    );
  }
}

// buildの中でuseProviderを使いcontrollerを宣言した場合
// 画面遷移時にinit, ボタン押下時にincrement, 画面を閉じたらdispose
class _FabUserProviderPattern extends HookWidget {
  const _FabUserProviderPattern({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(sampleStateNotifierProvider(4));
    return FloatingActionButton(
      onPressed: controller.increment,
    );
  }
}

// context.readの場合
// ボタン押下時ににinit, increment, dispose をすべて行う
class _FabContextPattern extends StatelessWidget {
  const _FabContextPattern({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read(sampleStateNotifierProvider(5)).increment(),
    );
  }
}
