import 'package:flutter/material.dart';
import 'package:flutter_playground/riverpod/state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 通常のProvider（値を渡すだけ）
final sampleProvider = Provider((ref) => 'tsuruoka4');
final sampleStateProvider = StateProvider((ref) => 'tsuruokaState');

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        StateNotifierPage.routeName: (context) => const StateNotifierPage(),
      },
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            ListTile(
              title: const Text('StateNotifier'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () =>
                  Navigator.pushNamed(context, StateNotifierPage.routeName),
            )
          ],
        ));
  }
}

//
//class _Text extends HookWidget {
//  const _Text({
//    Key? key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Text(useProvider(sampleProvider));
//  }
//}
//
//class _StateNotifierText extends HookWidget {
//  const _StateNotifierText({Key? key}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Text(useProvider(sampleStateNotifierProvider.state).toString());
//  }
//}
//
//// stateless widgetだけでなく、statefulのwidgetも用意されている
//class _StateFulSample extends StatefulHookWidget {
//  const _StateFulSample({Key? key}) : super(key: key);
//  @override
//  _StateFulSampleState createState() => _StateFulSampleState();
//}
//
//class _StateFulSampleState extends State<_StateFulSample> {
//  @override
//  Widget build(BuildContext context) {
//    return Text('this is stateful : ${useProvider(sampleProvider)}');
//  }
//}
