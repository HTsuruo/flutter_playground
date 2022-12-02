import 'package:flutter/material.dart';
import 'package:flutter_playground/tab_bar/components/components.dart';

///　TabBarの見た目を色々いじる画面
class CustomizedTabBarPage extends StatefulWidget {
  const CustomizedTabBarPage({super.key});
  static const routeName = '/customized_tab_bar';

  @override
  State<CustomizedTabBarPage> createState() => _CustomizedTabBarPageState();
}

class _CustomizedTabBarPageState extends State<CustomizedTabBarPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: tabs.length,
    vsync: this,
  );

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
          tabs: tabs.map((t) => t.tab).toList(),
          labelColor: colorScheme.primary,
          labelStyle: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.yellowAccent,
          ),
          unselectedLabelStyle: theme.textTheme.bodyMedium,
          unselectedLabelColor: Colors.white,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          indicatorPadding: const EdgeInsets.all(8),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs
            .map(
              (t) => Center(
                child: Text(t.tab.toString()),
              ),
            )
            .toList(),
      ),
    );
  }
}
