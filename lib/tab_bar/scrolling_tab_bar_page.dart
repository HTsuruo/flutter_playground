import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/components.dart';

/// 下記Material Designドキュメントにある、TabBarが隠れる
/// https://material.io/components/tabs#behavior -> Scrolling
class ScrollingTabBarPage extends HookWidget {
  const ScrollingTabBarPage({Key key}) : super(key: key);
  static const routeName = '/scrolling_tab_bar_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(routeName),
              bottom: TabBar(
                tabs: tabs.map((t) => t.tab).toList(),
              ),
            ),
            // Containerだと[SliverAppBar]が隠れるのが確認できる
            // SliverFillRemaining(
            //   child: TabBarView(
            //     children: containerTabs.map((t) => t.pageView).toList(),
            //   ),
            // ),
            // TODO(tsuruoka): [pageView]がListViewなので[SliverToBoxAdapter]の
            //  childに持たせる形を考えていたがうまく表示できず。
            // また、[CustomScrollView]のスクロールと[ListView]のスクロールが競合する気がしていて
            // その辺りの解決策も知りたい
            SliverToBoxAdapter(
              child: TabBarView(
                children: tabs.map((t) => t.pageView).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
