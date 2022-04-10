import 'package:flutter/material.dart';
import 'package:flutter_playground/transition_sample/detail.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        splashFactory: InkRipple.splashFactory,
//        pageTransitionsTheme: const PageTransitionsTheme(
        // 空にすると全プラットフォームでFadeUpwardsPageTransitionsBuilderが使われる
//          builders: <TargetPlatform, PageTransitionsBuilder>{},
//        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text('画面遷移'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const Detail(),
                ),
              ),
            ),
            ListTile(
              title: const Text('ディレイ画面遷移'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => Navigator.of(context).delayedPush<void>(
                MaterialPageRoute(
                  builder: (context) => const Detail(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension NavigatorStateEx on NavigatorState {
  Future<T?> delayedPush<T extends Object?>(Route<T> route) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return push(route);
  }
}
