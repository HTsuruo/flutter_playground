import 'package:flutter/material.dart';

import 'components/components.dart';

/// 下記Material Designドキュメントにある、TabBarが隠れる
/// https://material.io/components/tabs#behavior -> Scrolling
class ScrollingTabBarPage extends StatelessWidget {
  const ScrollingTabBarPage({super.key});
  static const routeName = '/scrolling_tab_bar_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        // ref. https://api.flutter.dev/flutter/widgets/NestedScrollView-class.html
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text(routeName),
                  bottom: TabBar(
                    tabs: tabs.map((t) => t.tab).toList(),
                  ),
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            ];
          },
          // [CustomScrollView]を中身に持つTabBarViewの場合
          body: TabBarView(
            // TabBarViewの中身をCustomScrollViewにしてSliverで構築することも可能
            children: tabsIncludingSliver.map((t) => t.pageView).toList(),
          ),
          // [ListView]を中身に持つTabBarViewの場合
          // body: TabBarView(
          //   // TabBarViewの中身をCustomScrollViewにしてSliverで構築することも可能
          //   children: tabs.map((t) => t.pageView).toList(),
          // ),
        ),
      ),
    );
  }
}
