import 'package:flutter_playground/logger.dart';
import 'package:intl/intl.dart';

// NumberFormat
// ref. https://api.flutter.dev/flutter/intl/NumberFormat-class.html

// NumberFormat.compact
// ref. https://api.flutter.dev/flutter/intl/NumberFormat/NumberFormat.compact.html
void main() {
  logger.info(123.compact);
  logger.info(123456.compact);
  logger.info(123456789.compact);
  logger.info(123456789012.compact);
}

final fmt = NumberFormat.compact();

extension on int {
  String get compact => fmt.format(this);
}
