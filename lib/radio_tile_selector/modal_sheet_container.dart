import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ModalSheetContainer extends HookWidget {
  const ModalSheetContainer({
    Key? key,
    required this.title,
    required this.child,
    this.subTitle,
    this.scrollController,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Widget child;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const topPadding = kToolbarHeight;

    return SafeArea(
      // ヘッダーを固定し中身のみスクローラブル領域
      // bottomModalSheet用途で不要な高さを表示はしたくないので、
      // `shrinkWrap: true`を機能させるためにStackで重ねる作りにした
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: topPadding),
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              children: [
                child,
              ],
            ),
          ),
          // ヘッダー
          Container(
            color: theme.colorScheme.primary,
            height: topPadding,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                    if (subTitle != null)
                      Text(
                        subTitle!,
                        style: theme.textTheme.caption!.copyWith(
                          color: theme.colorScheme.surface,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
