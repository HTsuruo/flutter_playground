import 'package:flutter/material.dart';
import 'package:flutter_playground/snackbars/scaffold_messenger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubPage extends ConsumerWidget {
  const SubPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サブページ'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('hideSnackBar'),
          onPressed: () {
            // routeが変わっても、ScaffoldMessengerで共通で管理されている
            // （MaterialAppのscaffoldMessengerKey?を指定した場合）ので
            // 他の画面で表示されたsnackBarも操作できる
            ref.read(scaffoldMessengerKey).currentState!.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
