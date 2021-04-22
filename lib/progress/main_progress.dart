import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_playground/progress/progress_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(progressController);
    return ModalProgressHUD(
      inAsyncCall: controller.inAsyncCall,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // このブロックで囲まれている処理が終わるまでプログレス表示
              controller.executeWithProgress(
                () async => {
                  // ダミー処理時間として3秒待つ
                  await Future<void>.delayed(const Duration(seconds: 3)),
                },
              );
            },
            child: const Text('async start'),
          ),
        ),
      ),
    );
  }
}
