import 'package:flutter/material.dart';
import 'package:flutter_playground/gen/assets.gen.dart';
import 'package:flutter_playground/logger.dart';
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

  @override
  void initState() {
    super.initState();
    _animation.addListener(() {
      logger.info('animation value: ${_animation.value}');
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
              .map(
                (tab) => Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tab.svgGenImage.svg(height: 20),
                      const Gap(4),
                      Text(tab.name.toUpperCase())
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
            )
        ],
      ),
    );
  }
}

enum _Fruit {
  apple,
  grape,
  pear,
  ;
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
