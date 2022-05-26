import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _mockFutureProvider = FutureProvider<int>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 3));
  return Future.value(5);
});

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  static const routeName = '/future_provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(_mockFutureProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          runtimeType.toString(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const _AutoDisposePage(),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          )
        ],
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

final _autoDisposeProvider = FutureProvider.autoDispose<int>(
  (ref) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    ref.onDispose(() {
      logger.info('onDispose!!');
    });
    return Future.value(5);
  },
  cacheTime: const Duration(seconds: 5),
  // disposeDelay: const Duration(seconds: 5),
);

class _AutoDisposePage extends ConsumerWidget {
  const _AutoDisposePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(_autoDisposeProvider).value;
    logger.info('count: $count');
    return Scaffold(
      appBar: AppBar(
        title: const Text('autoDispose'),
      ),
      body: Center(
        child: Text('count: $count'),
      ),
    );
  }
}
