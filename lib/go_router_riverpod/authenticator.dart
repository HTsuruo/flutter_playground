import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authenticator.g.dart';

@Riverpod(keepAlive: true)
class Authenticator extends _$Authenticator {
  @override
  FutureOr<bool> build() async {
    await _delayed;
    return false;
  }

  final _delayed = Future<void>.delayed(const Duration(seconds: 3));

  Future<void> signIn() async {
    // AsyncLoadingを挟むとうまくいく
    // TODO(htsuruo): うまく変更は流れるが3秒ディレイが効かずに即時に画面が切り替わってしまう。
    // state = const AsyncLoading();
    await _delayed;
    state = const AsyncData(true);
  }

  Future<void> signOut() async {
    // AsyncLoadingを挟むとうまくいく
    // state = const AsyncLoading();
    await _delayed;
    // TODO(htsuruo): これでStateを更新しても`.future`で取得しても最新値(false)は取得できない
    state = const AsyncData(false);
  }
}
