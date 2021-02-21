import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TabBarFirstView extends HookWidget {
  const TabBarFirstView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: ListView.builder(
        key: const PageStorageKey('TabBarFirstView'),
        itemBuilder: (context, index) => ListTile(
          title: Text('First: $index'),
        ),
      ),
    );
  }
}
