import 'package:flutter/material.dart';
import 'package:flutter_playground/loading/future_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

// Loading中のスケルトンスクリーンのサンプル
class ShimmerPage extends ConsumerWidget {
  const ShimmerPage({super.key});

  static const routeName = '/loading/shimmer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureMock).value;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: value == null
          ? Shimmer.fromColors(
              baseColor: colorScheme.onSurface.withOpacity(.2),
              highlightColor: colorScheme.onSurface.withOpacity(.05),
              // ListTileのPaddingに合わせる
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    // Transparentな要素にはShimmerのColorが効かないので適当に色を指定する
                    color: colorScheme.onSurface,
                    width: constraints.maxWidth / 2,
                    height: 22,
                  ),
                ),
              ),
            )
          : ListTile(
              title: Text(value),
            ),
    );
  }
}
