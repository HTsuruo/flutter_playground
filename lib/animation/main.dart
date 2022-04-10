import 'package:flutter/material.dart';
import 'package:flutter_playground/animation/implicitly_animated/animated_container.dart';
import 'package:flutter_playground/animation/implicitly_animated/animated_switcher.dart';
import 'package:flutter_playground/playground_builder.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      AnimatedSwitcherPage.routeName: (context) => const AnimatedSwitcherPage(),
      AnimatedContainerPage.routeName: (context) =>
          const AnimatedContainerPage(),
    };
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(useMaterial3: true),
      home: PlaygroundBuilder(
        title: 'Animation',
        routes: routes,
      ),
    );
  }
}
