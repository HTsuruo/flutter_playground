import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _mockFutureProvider = FutureProvider<int>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 3));
  return Future.value(5);
});

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({Key? key}) : super(key: key);

  static const routeName = '/future_provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(_mockFutureProvider).value;
    logger.info('value: $value');
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
