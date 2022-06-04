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
    logger.info('provider: : ${ref.hashCode}');
    final plusOne = ref.watch(_plusOneProvider);
    ref.onDispose(() {
      logger.info('onDispose: ${ref.hashCode}');
    });
    return Future.value(5 + plusOne);
  },
  cacheTime: const Duration(seconds: 5),
  // disposeDelay: const Duration(seconds: 5),
);

final _plusOneProvider = StateProvider.autoDispose<int>((ref) {
  // `_autoDisposeProvider`がdisposeされると即時破棄される
  ref.onDispose(() {
    logger.info('plusOneProvider - onDispose: ${ref.hashCode}');
  });
  return 0;
});

class _AutoDisposePage extends ConsumerWidget {
  const _AutoDisposePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(_autoDisposeProvider.select((s) => s.value));
    logger.info('count: $count');
    return Scaffold(
      appBar: AppBar(
        title: const Text('autoDispose'),
      ),
      body: Center(
        child: Text('count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.info('plusOne!!');
          ref.read(_plusOneProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
