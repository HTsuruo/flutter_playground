import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final infinityScrollDetector = Provider.autoDispose(
  (ref) {
    final detector = InfinityScrollDetector();
    ref.onDispose(detector.dispose);
    return detector;
  },
);

class InfinityScrollDetector {
  InfinityScrollDetector() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        _canNext = true;
      }
    });
  }
  late final scrollController = ScrollController();
  var _canNext = false;
  bool get canNext => _canNext;

  void dispose() {
    scrollController.dispose();
  }
}
