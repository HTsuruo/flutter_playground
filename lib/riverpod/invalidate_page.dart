import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _fakeProvider = FutureProvider<int>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return 5 * ref.watch(_fooProvider);
});

final _fooProvider = Provider<int>((ref) {
  return 2;
});

class InvalidatePage extends ConsumerWidget {
  const InvalidatePage({super.key});

  static const routeName = '/invalidate';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invalidate'),
      ),
      body: Center(
        child: ref.watch(_fakeProvider).when(
              skipLoadingOnRefresh: false,
              loading: CircularProgressIndicator.new,
              error: (error, stackTrace) => Text('error: $error'),
              data: (date) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(date.toString()),
                    const Gap(8),
                    OutlinedButton(
                      onPressed: () {
                        ref.invalidate(_fakeProvider);
                      },
                      child: const Text('invalidate fakeProvider'),
                    ),
                    const Gap(8),
                    OutlinedButton(
                      onPressed: () {
                        ref.invalidate(_fooProvider);
                      },
                      child: const Text('invalidate fooProvider'),
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }
}
