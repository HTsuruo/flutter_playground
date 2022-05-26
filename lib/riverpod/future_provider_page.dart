import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _mockFutureProvider = FutureProvider<int>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 3));
  return Future.value(5);
});

final stateProvider = StateProvider<Model>((ref) {
  final value = ref.watch(_mockFutureProvider).value;
  final value2 = ref.watch(_mockFutureProvider).value;
  final value3 = ref.watch(_mockFutureProvider).value;
  return Model(value: value, value2: value2, value3: value3);
});

class Model {
  Model({
    required this.value,
    required this.value2,
    required this.value3,
  });
  final int? value;
  final int? value2;
  final int? value3;
}

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  static const routeName = '/future_provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(_mockFutureProvider).value;
    final model = ref.watch(stateProvider);
    logger
      ..info('value: $value')
      ..info('model: $model');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          runtimeType.toString(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          logger.info('onRefresh!!');
          ref.refresh(_mockFutureProvider);
          return Future<void>.value();
        },
        child: value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('index: $index'),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
      ),
    );
  }
}
