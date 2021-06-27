import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProviderController = ChangeNotifierProvider.autoDispose(
  (ref) => StateProviderController(ref.read),
);

// サンプルなので命名は仮
final stateProvider = StateProvider<String?>((ref) => null);

class StateProviderController extends ChangeNotifier {
  StateProviderController(this._read) {
    /// これは呼ばれる
    logger.fine(state);

    // これは呼ばれない
    // 購読前にデータが確定しているためここには流れてこない
    // つまり、StateProviderのStreamはBehaviorSubjectのような以前のイベントを流すものではない
    // ということですかね？
    // ソース見たら`StreamController<T>.broadcast()`となってましたね、理解です
    // StreamController.broadcastだと購読以降のイベントしか流れてこないので別途streamを用意して格納するなど必要そう
    // そもそもそんなケースは少ない???
    _sh = _read(stateProvider).stream.listen(logger.fine);
  }

  final Reader _read;
  String get state => _read(stateProvider).state!; // `requireState`などとすると良い
  late final StreamSubscription _sh;

  @override
  void dispose() {
    _read(stateProvider).state = null;
    _sh.cancel();
    super.dispose();
  }
}
