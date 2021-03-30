import 'package:flutter/material.dart';
import 'package:flutter_playground/snackbars/scaffold_messenger_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubPage extends StatelessWidget {
  const SubPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サブページ'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('hideSnackBar'),
          onPressed: () {
            // routeが変わっても、ScaffoldMessengerで共通で管理されている
            // （MaterialAppのscaffoldMessengerKeyを指定した場合）ので
            // 他の画面で表示されたsnackBarも操作できる
            context
                .read(scaffoldMessengerKey)
                .currentState
                .hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
