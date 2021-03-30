import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_playground/snackbars/navigator_provider.dart';
import 'package:flutter_playground/snackbars/scaffold_messenger_provider.dart';
import 'package:flutter_playground/snackbars/sub_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

import '../logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const locale = Locale('ja');
    logger.fine(rootScaffoldMessengerKey);
    return MaterialApp(
      navigatorKey: useProvider(navigatorKey),
      scaffoldMessengerKey: useProvider(scaffoldMessengerKey),
      locale: locale,
      supportedLocales: const [locale],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
        // ThemeData指定もできる
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.redAccent,
        ),
      ),
      home: const HomePage(),
    );
  }
}

const _snackBar = SnackBar(
  content: Text('snackBarContent'),
  duration: const Duration(seconds: 2),
);

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('ScaffoldMessenger.of.showSnackBar'),
            subtitle: const Text('直接ScaffoldMessengerStateを呼ぶ方法'),
            onTap: () async {
              final featureController =
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
              // どんな操作で閉じられたか取得できる
              final closeReason = await featureController.closed;
              logger.fine('closeReason: $closeReason');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('hideCurrentSnackBar'),
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
          const Divider(),
          ListTile(
            title: const Text('removeCurrentSnackBar'),
            // The removed snack bar does not run its normal exit animation
            // 基本的にはhideが使われるはず
            onTap: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
          ),
          const Divider(),
          ListTile(
            title: const Text(
                'rootScaffoldMessengerKey.currentState.showSnackBar'),
            subtitle: const Text('GlobalKeyをMaterialAppにセットして呼び出す'),
            // `rootScaffoldMessengerKey`をscaffoldMessengerKeyに
            // セットしないと存在しないのでエラーになる
            onTap: () =>
                rootScaffoldMessengerKey.currentState.showSnackBar(_snackBar),
          ),
          const Divider(),
          ListTile(
            title: const Text('Provider経由でGlobalKeyを呼び出す'),
            onTap: () => context
                .read(scaffoldMessengerKey)
                .currentState
                .showSnackBar(_snackBar),
          ),
          const Divider(),
          ListTile(
            // backgroundColorなどSnackBarThemeDataで弄れる箇所はそちらで指定するのがベター
            title: const Text('SnackBarを弄る'),
            onTap: () {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                elevation: 6, //default 6.0
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(
                  top: 5,
                  bottom: 10,
                ), // default `EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0)`
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blueAccent,
                duration: const Duration(seconds: 5),
                content: const Text('Custom SnackBar Content\nhogehogehge'),
                action: SnackBarAction(
                  label: 'action',
                  onPressed: () => logger.fine('onPressed action!!'),
                ),
              );
              context
                  .read(scaffoldMessengerKey)
                  .currentState
                  .showSnackBar(snackBar);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Navigator.of().push'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const SubPage(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
