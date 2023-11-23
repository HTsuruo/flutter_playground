import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'authenticator.dart';
import 'main.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  // ref. https://github.com/lucavenir/go_router_riverpod/blob/e1b166c1ebac1e601d0c6eb41bfc379275def76c/example/lib/router/router.dart#L25-L39
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose)
    ..listen(
      authenticatorProvider,
      (_, next) {
        isAuth.value = next;
      },
    );

  return GoRouter(
    navigatorKey: routerKey,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: isAuth,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => const HomePage(),
      ),
      GoRoute(
        path: '/signin',
        // TODO(htsuruo): サインアウト時"のみ"BackwardTransitionPageを適用したい
        pageBuilder: (context, state) => const BackwardTransitionPage(
          child: SigninPage(),
        ),
      ),
      GoRoute(
        path: '/splash',
        pageBuilder: (context, _) => const NoTransitionPage(
          child: SplashPage(),
        ),
      ),
    ],
    redirect: (context, state) {
      if (isAuth.value.isLoading || !isAuth.value.hasValue) {
        return '/splash';
      }
      final isSignedIn = isAuth.value.requireValue;
      final location = state.uri.toString();
      final isSigninLocation = location == '/signin';
      if (!isSignedIn) {
        return isSigninLocation ? null : '/signin';
      }
      if (isSigninLocation) {
        return '/';
      }
      return null;
    },
  );
}

class BackwardTransitionPage<T> extends CustomTransitionPage<T> {
  const BackwardTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(transitionsBuilder: _transitionsBuilder);

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // ref. https://docs.flutter.dev/cookbook/animation/page-route-animation
    const begin = Offset(-1, 0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: Curves.easeInOut),
    );
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
