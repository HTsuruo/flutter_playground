import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// このProviderを外部から色々呼んでみる
final sampleProvider = Provider.autoDispose(
  (ref) {
    final sample = Sample();
    ref.onDispose(sample.dispose);
    return sample;
  },
);

class Sample {
  Sample() {
    logger.info('constructor');
  }

  void doSomething() {
    logger.info('doSomething');
  }

  void dispose() {
    logger.info('dispose');
  }
}
