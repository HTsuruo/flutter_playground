import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() {
    // 理解のためのログ
    print('tearDown');
  });

  test('StateProvider', () {
    final container = ProviderContainer();
    // 上のtearDownと同じだがcontainerのdisposeにはこちらが使いやすい
    addTearDown(container.dispose);
    // 理解のためのログ
    addTearDown(() => print('addTearDown'));
    // これはしなくても良いが、よく使うならスッキリする
    final read = container.read;

    expect(read(fooProvider).isLoading, isTrue);
    expect(read(fooProvider).hasValue, isFalse);

    read(fooProvider.notifier).update((_) => const AsyncData(1));
    expect(read(fooProvider).isLoading, isFalse);
    expect(read(fooProvider).hasValue, isTrue);

    read(fooProvider.notifier).update((_) => const AsyncLoading());
    expect(read(fooProvider).isLoading, isTrue);
    expect(read(fooProvider).hasValue, isTrue, reason: '直前の値を持つので');
  });
}

final fooProvider = StateProvider<AsyncValue<int>>(
  (ref) => const AsyncLoading(),
);
