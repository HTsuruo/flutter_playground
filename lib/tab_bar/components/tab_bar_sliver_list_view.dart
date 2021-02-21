import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TabBarSliverListView extends HookWidget {
  const TabBarSliverListView({
    Key key,
    @required this.color,
    @required this.pageName,
  }) : super(key: key);

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
