import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProviderController = ChangeNotifierProvider.autoDispose(
  StateProviderController.new,
);

// サンプルなので命名は仮
final stateProvider = StateProvider<String?>((ref) => null);

class StateProviderController extends ChangeNotifier {
  StateProviderController(this._ref) {
    /// これは呼ばれる
    logger.info(state);

    // これは呼ばれない
    // 購読前にデータが確定しているためここには流れてこない
    // つまり、StateProviderのStreamはBehaviorSubjectのような以前のイベントを流すものではない
    // ということですかね？
    // ソース見たら`StreamController<T>.broadcast()`となってましたね、理解です
    // StreamController.broadcastだと購読以降のイベントしか流れてこないので別途streamを用意して格納するなど必要そう
    // そもそもそんなケースは少ない???
    _sh = _ref.read(stateProvider.notifier).stream.listen(logger.info);
  }

  final Ref _ref;
  String get state => _ref.read(stateProvider)!; // `requireState`などとすると良い
  late final StreamSubscription<String?> _sh;

  @override
  void dispose() {
    _ref.read(stateProvider.notifier).update((_) => null);
    _sh.cancel();
    super.dispose();
  }
}
