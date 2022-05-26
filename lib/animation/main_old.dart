import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late final curvedAnimate = CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,
  );
  late final Animation<Color?> animation =
      ColorTween(begin: Colors.redAccent, end: Colors.blue)
          .animate(curvedAnimate);

  @override
  void initState() {
    super.initState();
    animation.addListener(() {
      setState(() {});
    });
    // animation.addStatusListener((status) {
    //   logger.info('animationStatus: $status');
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
          Text('value: ${animation.value}'),
          _AnimatedContainer(animation: animation),
        ],
      ),
    );
  }
}

// AnimatedWidgetを継承すれば、リスナーの登録やsetStateの再描画などを意識する必要がなくなる
class _AnimatedContainer extends AnimatedWidget {
  const _AnimatedContainer({
    super.key,
    required this.animation,
  }) : super(listenable: animation);

  final Animation<Color?> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: animation.value,
    );
  }
}
