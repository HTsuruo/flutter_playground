import 'package:flutter/foundation.dart';

enum SampleType {
  hoge,
  piyo,
  sample,
  sample2,
}

extension SampleTypeEx on SampleType {
  String get label => describeEnum(this);
}

enum HogeType {
  hoge1,
  hoge2,
  hoge3,
  hoge4,
  hoge5,
}

extension HogeTypeEx on HogeType {
  String get label => describeEnum(this);
}
