import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/tab_bar/components/components.dart';

///　[TabController]と[TickerProviderStateMixin]で構築するパターン
class TabControllerPage extends StatefulWidget {
  const TabControllerPage({Key key}) : super(key: key);
  static const routeName = '/tab_controller_page';

  @override
  _TabControllerPageState createState() => _TabControllerPageState();
}

class _TabControllerPageState extends State<TabControllerPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    // TabViewスワイプアクションを検知したい場合はaddListerで変更を監視する
    // 但し、TabBarタップ時にはタップ操作とTabViewの変更検知で重複して2回呼ばれるのでケアが必要
    _tabController.addListener(
      () {
        final previousIndex = _tabController.previousIndex;
        final currentIndex = _tabController.index;
        // True while we're animating from previousIndex to index
        // as a consequence of calling animateTo
        // アニメーション中にはtrueを返すものだが「TabBar押下時」のみtrueになるため
        // TabBar押下かスワイプによる変更か判断することができる
        if (_tabController.indexIsChanging) {
          return;
        }
        // indexの変更が完了したタイミング（アニメーション終了後）に行いたい処理
        // ...
        logger.fine('Changed Tab Index: $previousIndex → $currentIndex');
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TabControllerPage.routeName),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.entries.map((e) => e.key).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.entries.map((e) => e.value).toList(),
      ),
    );
  }
}
