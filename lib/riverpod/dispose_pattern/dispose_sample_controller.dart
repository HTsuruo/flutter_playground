import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 例えばこういったページ単位で破棄される想定のautoDispose系のControllerでは
// 寿命の長いStream（もしくはメモリを逼迫するような処理）を仮に購読していた場合に
// dispose時にしっかり購読を解除しないと、インスタンスが存在しない宙ぶらりんなクラスに
// Streamが流れ続けてしまいガベージコレクションも働かず永遠にメモリを逼迫してしまう
final disposeSampleController = Provider.autoDispose(
  (ref) {
    final controller = DisposeSampleController();
    ref.onDispose(controller.dispose);
    return controller;
  },
);

class DisposeSampleController {
  DisposeSampleController() {
    logger.info('$runtimeType: constructor');
  }

  void dispose() {
    logger.info('$runtimeType: dispose');
  }
}
