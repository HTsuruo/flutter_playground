import 'package:flutter/material.dart';

import 'components.dart';

final tabs = <Tab, Widget>{
  const Tab(text: 'First'): const TabBarFirstView(),
  const Tab(text: 'Second'): const TabBarSecondView(),
};
