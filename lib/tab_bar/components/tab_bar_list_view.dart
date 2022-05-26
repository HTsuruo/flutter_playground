import 'package:flutter/material.dart';

class TabBarListView extends StatelessWidget {
  const TabBarListView({
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
      child: ListView.builder(
        key: PageStorageKey(pageName),
        itemBuilder: (context, index) => ListTile(
          title: Text('$pageName: $index'),
        ),
      ),
    );
  }
}
