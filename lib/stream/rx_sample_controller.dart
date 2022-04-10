import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final rxSampleController = ChangeNotifierProvider.autoDispose(
  (ref) => RxSampleController(),
);

/// PublishSubject
/// BehaviorSubject
/// ReplaySubject
class RxSampleController extends ChangeNotifier {
  RxSampleController() {
    // 監視前にaddしたeventは`PublishSubject`では流れてこないが
    // `BehaviorSubject`では最後の発行を記憶してくれるので監視前のイベントも流れてくる
    _publishSubject.add('data0');
    _behaviorSubject.add('data0');
    _replySubject.add('data0');

    // 「最後の発行」がポイントで複数のイベントがある場合は最後のイベントのみが対象
    // 例えばこの場合監視前に`data0``data0.5`が発行されているが最後のイベント`data0.5`のみが流れてくる
    // _behaviorSubject.add('data0.5');

    // 対して、replySubjectでは過去の全てのイベントを取得できるので、`data0``data0.5`も流れてくる
    // ignore: cascade_invocations
    _replySubject.add('data0.5');

    // 購読者
    // ignore: cascade_invocations
    _publishSubject.listen((data) {
      logger.info('_publishSubject:subscriber1:$data');
    });

    _behaviorSubject.listen((data) {
      logger.info('_behaviorSubject:subscriber1:$data');
    });

    _replySubject.listen((data) {
      logger.info('_replySubject:subscriber1:$data');
    });

    // ignore: cascade_invocations
    _publishSubject
      ..add('data1')
      ..add('data2');
    _behaviorSubject
      ..add('data1')
      ..add('data2');
    _replySubject
      ..add('data1')
      ..add('data2');

    Future(() async {
      await Future<void>.delayed(const Duration(seconds: 3));
      _publishSubject.add('data3');
      _behaviorSubject.add('data3');
      _replySubject.add('data3');

      // 購読者
      // ignore: cascade_invocations
      _publishSubject.listen((data) {
        logger.info('_publishSubject:subscriber2:$data');
      });

      _behaviorSubject.listen((data) {
        logger.info('_behaviorSubject:subscriber2:$data');
      });

      // ReplySubjectの特徴
      // この購読では過去に発行したdata0~data3まですべて流れてくる
      _replySubject.listen((data) {
        logger.info('_replySubject:subscriber2:$data');
      });

      // ignore: cascade_invocations
      _publishSubject.add('data4');
      _behaviorSubject.add('data4');
      _replySubject.add('data4');
    });
  }

  // `StreamController<String>.broadcast`と同様
  final _publishSubject = PublishSubject<String>();

  // 発行を記憶してくれてlistenしたタイミングで一番最後に発行したデータを処理できる
  final _behaviorSubject = BehaviorSubject<String>();

  // 発行を記憶してくれてlistenしたタイミングでこれまで発行したすべてデータを処理できる
  final _replySubject = ReplaySubject<String>();

  @override
  void dispose() {
    _publishSubject.close();
    _behaviorSubject.close();
    _replySubject.close();
    super.dispose();
  }
}
