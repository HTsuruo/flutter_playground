import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const locale = Locale('ja');
    return MaterialApp(
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
      ),
      home: const HomePage(),
    );
  }
}

// AnimationControllerを使ってハンドリングするスタンダードなアニメーション方法
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    final curvedAnimate = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    animation = ColorTween(begin: Colors.redAccent, end: Colors.blue)
        .animate(curvedAnimate);
    animation.addListener(() {
      setState(() {});
    });
    // animation.addStatusListener((status) {
    //   logger.fine('animationStatus: $status');
    //   switch (status) {
    //     case AnimationStatus.completed:
    //       controller.reverse();
    //       break;
    //     case AnimationStatus.dismissed:
    //       controller.forward();
    //       break;
    //     case AnimationStatus.reverse:
    //     case AnimationStatus.forward:
    //       break;
    //   }
    // });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          runtimeType.toString(),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            color: animation.value,
          ),
          Text('value: ${animation?.value}'),
          _AnimatedContainer(animation: animation),
        ],
      ),
    );
  }
}

// AnimatedWidgetを継承すれば、リスナーの登録やsetStateの再描画などを意識する必要がなくなる
class _AnimatedContainer extends AnimatedWidget {
  const _AnimatedContainer({
    Key key,
    this.animation,
  }) : super(key: key, listenable: animation);

  final Animation<Color> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: animation.value,
    );
  }
}
