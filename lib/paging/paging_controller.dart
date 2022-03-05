import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final pagingProvider = Provider.autoDispose(
  (ref) {
    final paging = PagingController();
    ref.onDispose(paging.dispose);
    return paging;
  },
);

class PagingController {
  PagingController() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        logger.info('scrolled!!');
        if (length != _prevLength) {
          _hasMore = true;
        }
        _page.add(_page.value! + 1);
        _prevLength = length;
      }
    });
  }
  late final scrollController = ScrollController();
  int length = 0;
  int _prevLength = 0;
  final _page = BehaviorSubject<int>.seeded(1);
  var _hasMore = false;
  bool get hasMore => _hasMore;

  void dispose() {
    scrollController.dispose();
    _page.close();
  }
}
