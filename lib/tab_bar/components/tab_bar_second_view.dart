import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TabBarSecondView extends HookWidget {
  const TabBarSecondView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.orange,
      child: ListView.builder(
        key: const PageStorageKey('TabBarSecondView'),
        itemBuilder: (context, index) => ListTile(
          title: Text('Second: $index'),
        ),
      ),
    );
  }
}
