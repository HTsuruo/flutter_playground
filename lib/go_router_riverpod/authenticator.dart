import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

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
    await ref
        .read(progressController.notifier)
        .executeWithProgress<void>(() => _delayed);
    state = const AsyncData(true);
  }

  Future<void> signOut() async {
    await ref
        .read(progressController.notifier)
        .executeWithProgress<void>(() => _delayed);
    state = const AsyncData(false);
  }
}
