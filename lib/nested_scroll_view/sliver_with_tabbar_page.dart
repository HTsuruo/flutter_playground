import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _tabs = ['Tab1', 'Tab2'];

/// ScaffoldのAppBarをステータスバーとして活用してスクロール時のステータスバー干渉を防ぐケース
class SliverWithTabBarPage extends StatelessWidget {
  const SliverWithTabBarPage({super.key});

  static const routeName = '/nested_scroll_view/sliver_with_tabbar_page';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      // appBarを指定することでスクロール時にステータスバーが干渉しない形にできる
      appBar: const _TransparentAppBar(),
      body: ColoredBox(
        color: Colors.lightBlueAccent,
        child: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: Text(
                      runtimeType.toString(),
                      style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.surface,
                      ),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    // TODO(tsuruoka): title部分は隠しつつ、TabBarのみ固定する方法はあるのだろうか
                    // Twitterの通知タブの「すべて」と「@ツイート」のような挙動のイメージ
                    bottom: TabBar(
                      tabs: _tabs.map((name) => Tab(text: name)).toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tabs.map((e) {
                return Builder(builder: (context) {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                            title: Text('$index'),
                          ),
                        ),
                      ),
                    ],
                  );
                },);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _TransparentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _TransparentAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => Size.zero;
}
