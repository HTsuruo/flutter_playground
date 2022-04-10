import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
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
      logger
        ..info('scrollController.offset: ${scrollController.offset}')
        ..info(
          'scrollController.offset: '
          '${scrollController.position.maxScrollExtent}',
        );
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        _canNext = true;
        logger.info('maxScrollExtent');
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
