import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final streamSamplePageController = ChangeNotifierProvider.autoDispose(
  (ref) => StreamSamplePageController(),
);

class StreamSamplePageController extends ChangeNotifier {
  StreamSamplePageController() {
    //  broadCast指定しない場合、監視前に発行されたイベントも流れてくる
    // 購読は一つのみのrxdartのreplySubjectと捉えて良さそう？
    _singleController.sink.add('SingleStream0');
    _singleController.sink.add('SingleStream0.5');

    // 購読者1
    _singleController.stream.listen((data) {
      logger.fine('subscriber[single]:$data');
    });

    // 購読者2（これは通常ブロードキャスト指定をしないと失敗する）
    // Bad state: Stream has already been listened to.
    // controller.stream.listen(logger.fine);

    _singleController.sink.add('SingleStream1');
    _singleController.sink.add('SingleStream2');

    // Broadcast指定したことによって流れてこなくなった
    // BroadCast配信の場合監視前にsink.addしたものは流れてこない
    // 監視する場所とsink.addする箇所が重要で、おそらく監視している状態でないと流せない?
    _broadcastController.sink.add('BroadCast0');
    // 購読者1
    _broadcastController.stream.listen((data) {
      logger.fine('subscriber[A]:$data');
    });
    // 購読者2
    _broadcastController.stream.listen((data) {
      logger.fine('subscriber[B]:$data');
    });
    _broadcastController.sink.add('BroadCast1');
    _broadcastController.sink.add('BroadCast2');

    // transformで監視している購読は`BroadCast3`がかなり早いタイミングで流れてくる
    _broadcastController.stream.transform(_transform()).listen((data) {
      logger.fine('subscriber[C]:$data');
    });
    _broadcastController.sink.add('BroadCast3');

    // StreamSubscriptionに渡してみる
    _sh = _broadcastController.stream.listen((data) {
      logger.fine('subscriber[D]:$data');
    });

    // StreamSubscriptionはこのような形でstreamデータをハンドリングすることが可能
    // ちなみに`onData`指定した場合、前述での監視はされる`onData`が優先される
    // 重複で監視することにはならない.　とはいえonDataであれば普通にlistenすれば良いので使う機会は少なそう
    // _sh.onData((data) {
    //   logger.fine('subscriber[D]:onData:$data');
    // });

    _broadcastController.sink.add('BroadCast4');

    Future(() async {
      await Future<void>.delayed(const Duration(seconds: 3));
      _sh.cancel();
      logger.fine('---subscriber[D] canceled---');
      // StreamSubscriptionをcancelすることでsubscriber[D]は`BroadCast5`を
      // 受け取らないというハンドリングができる
      // cancel以外にも`pause`や`resume`で流し込むstreamを一時停止,再開したりできる
      _broadcastController.sink.add('BroadCast5');
    });
  }

  // 一人の購読者に向けたStreamのコントローラ
  // only one single subscriber
  final _singleController = StreamController<String>();

  // 複数の購読者に向けたStreamのコントローラ
  final _broadcastController = StreamController<String>.broadcast();

  Stream<String> get data => _broadcastController.stream;

  // データ加工も色々できる
  StreamTransformer<String, String> _transform() {
    return StreamTransformer.fromHandlers(
        handleData: (value, sink) => sink.add('[HEADER]:$value'));
  }

  // listenの型がStreamSubscriptionで購読の状態をハンドリングすることができる
  StreamSubscription<String> _sh;

  @override
  void dispose() {
    _singleController.close();
    _broadcastController.close();

    // 今回の場合`_broadcastController.close()`でstreamController自体をcloseしているので
    // わざわざStreamSubscriptionで管理してcloseしなくとも
    // streamが流れっぱなしでメモリリーク的なことが起こる心配がないが、
    // 例えば監視する対象が他のファイルで定義されていたりFirestoreのstreamなどの場合は
    // streamそのもの自体を閉じることはできない?ので、StreamSubscriptionで監視対象を管理し
    // `cancel()`を呼ぶことでstreamが流れてくるのを塞ぎ止めている理解
    _sh.cancel();
    super.dispose();
  }
}
