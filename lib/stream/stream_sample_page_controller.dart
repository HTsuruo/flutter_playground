import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final streamSamplePageController = ChangeNotifierProvider.autoDispose(
  (ref) => StreamSamplePageController(),
);

class StreamSamplePageController extends ChangeNotifier {
  StreamSamplePageController() {
    // これは流れてくる
    _singleController.sink.add('SingleStream0');

    // 購読者1
    _singleController.stream.listen(logger.fine);

    // 購読者2（これは通常ブロードキャスト指定をしないと失敗する）
    // Bad state: Stream has already been listened to.
    // controller.stream.listen(logger.fine);

    _singleController.sink.add('SingleStream1');
    _singleController.sink.add('SingleStream2');

    // TODO(tsuruoka): Broadcast指定したことによって流れてこなくなった
    // BroadCast配信の場合監視前にsink.addしたものは流れてこない
    // 監視する場所とsink.addする箇所が重要で、おそらく監視している状態でないと流せない?
    _broadcastController.sink.add('BroadCast0');
    // 購読者1
    _broadcastController.stream.listen((data) {
      logger.fine('subscriber1:$data');
    });
    // 購読者2
    _broadcastController.stream.listen((data) {
      logger.fine('subscriber2:$data');
    });
    _broadcastController.sink.add('BroadCast1');
    _broadcastController.sink.add('BroadCast2');

    // TODO(tsuruoka): BroadCast1, BroadCast2が流れてこないのが不思議
    // また、監視後にsink.addすると（BroadCast3）流れてくるがBroadCast1,BroadCast2は消える
    _broadcastController.stream.transform(_transform()).listen((data) {
      logger.fine('subscriber3:$data');
    });
    _broadcastController.sink.add('BroadCast3');
  }

  // 一人の購読者に向けたStreamのコントローラ
  // only one single subscriber
  final _singleController = StreamController<String>();

  // 複数の購読者に向けたStreamのコントローラ
  final _broadcastController = StreamController<String>.broadcast();

  // データ加工も色々できる
  StreamTransformer<String, String> _transform() {
    return StreamTransformer.fromHandlers(
        handleData: (value, sink) => sink.add('[HEADER]:$value'));
  }

  @override
  void dispose() {
    _singleController.close();
    _broadcastController.close();
    super.dispose();
  }
}
