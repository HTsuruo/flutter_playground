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
