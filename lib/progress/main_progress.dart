import 'package:flutter/material.dart';
import 'package:flutter_playground/progress/progress_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(progressController);
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
