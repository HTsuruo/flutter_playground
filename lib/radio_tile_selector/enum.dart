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
