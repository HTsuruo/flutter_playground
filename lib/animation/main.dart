import 'package:flutter/material.dart';
import 'package:flutter_playground/animation/implicitly_animated/animated_container.dart';
import 'package:flutter_playground/animation/implicitly_animated/animated_physical_model.dart';
import 'package:flutter_playground/animation/implicitly_animated/animated_switcher.dart';
import 'package:flutter_playground/animation/transition/fade_transition.dart';
import 'package:flutter_playground/playground_builder.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      AnimatedSwitcherPage.routeName: (context) => const AnimatedSwitcherPage(),
      AnimatedContainerPage.routeName: (context) =>
          const AnimatedContainerPage(),
      AnimatedPhysicalModelPage.routeName: (context) =>
          const AnimatedPhysicalModelPage(),
      FadeTransitionPage.routeName: (context) => const FadeTransitionPage(),
    };
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(),
      home: PlaygroundBuilder(
        title: 'Animation',
        routes: routes,
      ),
    );
  }
}
