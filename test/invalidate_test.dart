// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// invalidateとrefreshの挙動の違いを知るテスト
/// invalidate: Providerが破棄されるのみで再評価されない(=起動時の未決定状態となる）
/// refresh: Providerが破棄され再評価される（=invalidate+read相当）
final timeProvider = Provider((ref) {
  ref.onDispose(() => print('timerProvider disposed'));
  final value = DateTime.now().millisecondsSinceEpoch;
  print('timeProvider: $value');
  return value;
});

void main() {
  test('', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    print('1');
    expect(container.read(timeProvider), isNotNull);
    print('2');
    // invalidateメソッドはvoid
    // invalidateされるとProviderは破棄される
    container.invalidate(timeProvider);
    print('3');
    await Future<void>(() {});
    // 少し待ってもこの時点では、invalidate後にtimeProviderは未算出(起動後全く触ってない状態と同等)
    print('4');
    expect(container.read(timeProvider), isNotNull);
    print('5');
    // invalidate + read 相当なので、timeProviderが再算出される
    // (値がここで本当に必要でないのであればinvalidateで済ませるべき)
    expect(container.refresh(timeProvider), isNotNull);
    print('6');
    // 他にリスナーがいる状態にする
    container.listen(
      timeProvider,
      (previous, next) => print('listener: $next'),
    );
    print('7');
    container.invalidate(timeProvider); // void
    print('8');
    await Future<void>(() {});
    // リスナーがいるので少し待つとtimeProviderが再算出される
    print('9');
  });
}
