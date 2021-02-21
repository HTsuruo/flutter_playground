import 'package:flutter/material.dart';

import 'components.dart';

final tabs = {
  const Tabs(
    Tab(text: 'First'),
    const TabBarFirstView(),
  ),
  const Tabs(
    Tab(text: 'Second'),
    const TabBarSecondView(),
  ),
};

@immutable
class Tabs {
  const Tabs(this.tab, this.pageView);
  final Tab tab;
  final Widget pageView;
}

// ListViewではない形（Container）ではSliver系でも理想の動きになるのか検証用
final containerTabs = {
  Tabs(
    const Tab(text: 'First'),
    Container(
      color: Colors.blue,
    ),
  ),
  Tabs(
    const Tab(text: 'Second'),
    Container(
      color: Colors.redAccent,
    ),
  ),
};
