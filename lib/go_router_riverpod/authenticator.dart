import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authenticator.g.dart';

@Riverpod(keepAlive: true)
class Authenticator extends _$Authenticator {
  @override
  FutureOr<bool> build() async {
    await _delayed;
    return false;
  }

  Future<void> get _delayed => Future<void>.delayed(const Duration(seconds: 3));

  Future<void> signIn() async {
    state = const AsyncLoading();
    await _delayed;
    state = const AsyncData(true);
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await _delayed;
    state = const AsyncData(false);
  }
}
