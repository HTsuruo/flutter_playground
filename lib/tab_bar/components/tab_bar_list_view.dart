import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TabBarListView extends HookWidget {
  const TabBarListView({
    Key? key,
    required this.color,
    required this.pageName,
  }) : super(key: key);

  final Color color;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: ListView.builder(
        key: PageStorageKey(pageName),
        itemBuilder: (context, index) => ListTile(
          title: Text('$pageName: $index'),
        ),
      ),
    );
  }
}
