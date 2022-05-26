import 'package:flutter/material.dart';
import 'package:flutter_playground/state_management/main_scaffold.dart';

class Ex1SetStatePage extends StatefulWidget {
  const Ex1SetStatePage({super.key});

  static const routeName = 'ex1_set_state_page';

  @override
  _Ex1SetStatePageState createState() => _Ex1SetStatePageState();
}

class _Ex1SetStatePageState extends State<Ex1SetStatePage> {
  int counter = 0;

  // change circle color
  void _changeColor() {
    // `_element!.markNeedsBuild()`により、`dirty`フラグがつけられ
    // Flutterフレームワークが毎フレーム定期的に呼ばれている`BuildOwner.buildScope`が
    // dirtyなElementからWidgetの再生性とElementツリーの更新を行っている
    // 肝はElementそのものを管理することにある
    // ref. https://zenn.dev/chooyan/articles/7c2bf39f81cbed
    setState(() => counter++);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: widget.runtimeType.toString(),
      counter: counter,
      onPressed: _changeColor,
    );
  }
}
