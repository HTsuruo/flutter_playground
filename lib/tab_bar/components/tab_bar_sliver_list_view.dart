import 'package:flutter/material.dart';

class TabBarSliverListView extends StatelessWidget {
  const TabBarSliverListView({
    super.key,
    required this.color,
    required this.pageName,
  });

  final Color color;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: CustomScrollView(
        key: PageStorageKey(pageName),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('$pageName: $index'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
