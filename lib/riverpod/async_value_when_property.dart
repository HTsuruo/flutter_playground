import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

/// AsyncValueの`.when`利用時に指定できるboolプロパティの挙動を確認するための画面
/// - skipLoadingOnReload
/// - skipLoadingOnRefresh
/// - skipError

// 数値を2倍にするか否かを管理するProvider
final doubleEnabledProvider = StateProvider((ref) => false);

final someProvider = FutureProvider.autoDispose((ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));

  // `doubleEnabledProvider`が更新されると、参照元である`someProvider`が再評価される
  // つまり、`doubleEnabledProvider`が更新される度にAsyncLoadingクラスを経由する
  return Future.value(42 * (ref.watch(doubleEnabledProvider) ? 2 : 1));
});

class AsyncValueWhenProperty extends ConsumerWidget {
  const AsyncValueWhenProperty({super.key});

  static const routeName = '/async_value_when_property';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isReloading = ref.watch(someProvider).isReloading;
    // final isLoading = ref.watch(someProvider).isLoading;
    // final isRefreshing = ref.watch(someProvider).isRefreshing;
    return Scaffold(
      appBar: AppBar(title: const Text('AsyncValue When Property')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ref.watch(someProvider).when(
                  skipLoadingOnReload: false,
                  skipLoadingOnRefresh: true,
                  skipError: false,
                  loading: CircularProgressIndicator.new,
                  data: (data) => Text('data: $data'),
                  error: (error, stackTrace) => Text('error: $error'),
                ),
            const Gap(44),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  child: const Text('Loading'),
                  onPressed: () {
                    ref
                        .read(doubleEnabledProvider.notifier)
                        .update((state) => !state);
                  },
                ),
                const Gap(8),
                OutlinedButton(
                  child: const Text('Refresh'),
                  onPressed: () => ref.refresh(someProvider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
