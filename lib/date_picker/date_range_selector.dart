import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateRangeSelector =
    StateNotifierProvider<DateRangeSelector, DateTimeRange?>(
  (ref) => DateRangeSelector(),
);

final now = DateTime.now();

class DateRangeSelector extends StateNotifier<DateTimeRange?> {
  DateRangeSelector() : super(null);

  void recently() {
    state = DateTimeRange(
      start: now,
      end: now.add(
        const Duration(days: 30),
      ),
    );
  }

  void monthly() {
    state = DateTimeRange(
      start: now,
      end: now.add(
        const Duration(days: 60),
      ),
    );
  }

  void yearly() {
    state = DateTimeRange(
      start: now,
      end: now.add(
        const Duration(days: 90),
      ),
    );
  }
}
