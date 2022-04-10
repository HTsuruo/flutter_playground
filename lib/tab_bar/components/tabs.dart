import 'package:flutter/material.dart';

import 'components.dart';

final tabs = {
  const Tabs(
    Tab(text: 'First'),
    TabBarListView(color: Colors.blueAccent, pageName: 'First'),
  ),
  const Tabs(
    Tab(text: 'Second'),
    TabBarListView(color: Colors.orange, pageName: 'Second'),
  ),
};

final tabsIncludingSliver = {
  const Tabs(
    Tab(text: 'First'),
    TabBarSliverListView(color: Colors.blueAccent, pageName: 'First'),
  ),
  const Tabs(
    Tab(text: 'Second'),
    TabBarSliverListView(color: Colors.orange, pageName: 'Second'),
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
