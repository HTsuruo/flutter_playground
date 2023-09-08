import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/fruits_icons.dart';
import 'package:flutter_playground/gen/assets.gen.dart';
import 'package:gap/gap.dart';

///　TabBarの見た目を色々いじる画面
class CustomizedTabBarPage extends StatefulWidget {
  const CustomizedTabBarPage({super.key});
  static const routeName = '/customized_tab_bar';

  @override
  State<CustomizedTabBarPage> createState() => _CustomizedTabBarPageState();
}

class _CustomizedTabBarPageState extends State<CustomizedTabBarPage>
    with SingleTickerProviderStateMixin {
  final fruits = _Fruit.values;
  late final TabController _tabController = TabController(
    length: fruits.length,
    vsync: this,
  );
  late final _animation = _tabController.animation!;
  late var _activeIndex = fruits.first.index;

  @override
  void initState() {
    super.initState();
    _animation.addListener(() {
      // スワイプ時の途中経過もanimationプロパティのaddListenierで逐一取得することも可能
      // logger.info('animation value: ${_animation.value}');
    });
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        return;
      }
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(CustomizedTabBarPage.routeName),
        bottom: TabBar(
          controller: _tabController,
          labelColor: colorScheme.primary,
          labelStyle: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: theme.textTheme.bodyMedium,
          unselectedLabelColor: Colors.white,
          indicatorPadding: const EdgeInsets.all(8),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          tabs: fruits
              .mapIndexed(
                (index, tab) => Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 選択中のindexを取得してsvgのカラー分岐をするのでも悪くはなさそうだが、
                      // スワイプ移動時にColorのleapが表現できず不自然になる。
                      // 一報、`IconData`として用意すればTab Widget 側でよしなに解釈してくれるので
                      // そうするのが良さそう。
                      Icon(tab.iconData, size: 16),
                      // tab.svgGenImage.svg(
                      //   height: 16,
                      //   color: _activeIndex == index
                      //       ? colorScheme.primary
                      //       : Colors.white,
                      // ),
                      const Gap(4),
                      Text(tab.name.toUpperCase()),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final tab in fruits)
            Center(
              child: Text(tab.name.toUpperCase()),
            ),
        ],
      ),
    );
  }
}

enum _Fruit {
  apple(iconData: Fruits.apple),
  grape(iconData: Fruits.grape),
  pear(iconData: Fruits.pear),
  ;

  const _Fruit({required this.iconData});
  final IconData iconData;
}

extension on _Fruit {
  SvgGenImage get svgGenImage {
    switch (this) {
      case _Fruit.apple:
        return Assets.fruits.apple;
      case _Fruit.grape:
        return Assets.fruits.grape;
      case _Fruit.pear:
        return Assets.fruits.pear;
    }
  }
}
