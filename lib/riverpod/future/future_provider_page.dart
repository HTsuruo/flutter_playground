import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/paging/paging_page.dart';
import 'package:flutter_playground/riverpod/future/future_auto_dispose_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _fakeApi = FutureProvider<int>((ref) async {
  if (ref.watch(_forceErrorProvider)) {
    throw Exception('force error');
  }
  await Future<void>.delayed(const Duration(seconds: 2));
  return Future.value(5);
});

final _fakeApi2 = Provider<AsyncValue<int>>((ref) {
  return ref.watch(_fakeApi).whenData((value) => value * 2);
});

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  static const routeName = '/future_provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final fakeAsync = ref.watch(_fakeApi);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fakeAsync = ref.watch(_fakeApi2);

    logger
      ..info('fakeAsync: ${fakeAsync.toString()}')
      ..info('isLoading: ${fakeAsync.isLoading}')
      ..info('isRefreshing: ${fakeAsync.isRefreshing}')
      ..info('hasValue: ${fakeAsync.hasValue}')
      ..info('hasError: ${fakeAsync.hasError}')
      ..info('===');
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
                  builder: (context) => const PagingPage(),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const FutureAutoDisposePage(),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          )
        ],
      ),
      body: Column(
        children: [
          const _ForceErrorCheckbox(),
          const Divider(),
          Expanded(
            child: Center(
              child: fakeAsync.isRefreshing
                  ? const CircularProgressIndicator()
                  : fakeAsync.when(
                      loading: CircularProgressIndicator.new,
                      error: (error, stackTrace) => Text(
                        'error: $error\n\n stackTrace: $stackTrace',
                      ),
                      data: (data) {
                        return RefreshIndicator(
                          color: colorScheme.onPrimary,
                          backgroundColor: colorScheme.primary,
                          onRefresh: () => ref.refresh(_fakeApi.future),
                          child: ListView.separated(
                            itemCount: 50,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('index: $index'),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

final _forceErrorProvider = StateProvider((ref) => false);

class _ForceErrorCheckbox extends ConsumerWidget {
  const _ForceErrorCheckbox();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CheckboxListTile(
      value: ref.watch(_forceErrorProvider),
      title: const Text('Force Error'),
      onChanged: (_) =>
          ref.read(_forceErrorProvider.notifier).update((state) => !state),
    );
  }
}
