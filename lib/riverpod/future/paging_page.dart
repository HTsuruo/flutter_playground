import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _paginatedCountProvider =
    FutureProvider.family.autoDispose<int, int>((ref, page) async {
  // page番号ごとにfamilyでインスタンスを作る
  // familyで指定されたpageをaddする
  final fetchedPages = ref.watch(_fetchedPages)..add(page);

  // 破棄されたら指定ページをremoveする
  ref.onDispose(() => fetchedPages.remove(page));

  final res = await Future<int>.delayed(const Duration(seconds: 2), () => 1);

  // 適当にデコード相当のことをしたとする
  final value = res * 5;

  return value;
});

// 既に取得したページ番号
final _fetchedPages = StateProvider((ref) => <int>[]);

class PagingSamplePage extends ConsumerWidget {
  const PagingSamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const perPage = 50;
    return Scaffold(
      appBar: AppBar(
        title: const Text('paging sample'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(_paginatedCountProvider(0).future),
        color: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ProviderScope(
              overrides: [
                _currentValue.overrideWithValue(
                  ref
                      .watch(_paginatedCountProvider(index ~/ perPage))
                      .whenData((value) => value),
                ),
              ],
              child: const _ListTile(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

final _currentValue = Provider<AsyncValue<int>>((ref) {
  throw UnimplementedError();
});

class _ListTile extends ConsumerWidget {
  const _ListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueAsync = ref.watch(_currentValue);
    return valueAsync.maybeWhen(
      data: (value) => ListTile(
        title: Text('value: $value'),
      ),
      orElse: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: _ShimmerTile(),
      ),
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final shimmerColor = colorScheme.onSurface.withOpacity(.2);
    const shimmerHeight = 12.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: shimmerHeight,
            color: shimmerColor,
          ),
          const Gap(8),
          Container(
            width: 16,
            height: shimmerHeight,
            color: shimmerColor,
          ),
        ],
      ),
    );
  }
}
