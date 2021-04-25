import 'package:flutter/material.dart';

class Ex1SetStatePage extends StatefulWidget {
  const Ex1SetStatePage({Key? key}) : super(key: key);

  static const routeName = 'ex1_set_state_page';

  @override
  _Ex1SetStatePageState createState() => _Ex1SetStatePageState();
}

class _Ex1SetStatePageState extends State<Ex1SetStatePage> {
  final defaultColor = Colors.blueAccent;
  final changedColor = Colors.redAccent;
  late Color color = defaultColor;

  // change circle color
  void _changeColor() {
    // `_element!.markNeedsBuild()`により、`dirty`フラグがつけられ
    // Flutterフレームワークが毎フレーム定期的に呼ばれている`BuildOwner.buildScope`が
    // dirtyなElementからWidgetの再生性とElementツリーの更新を行っている
    // 肝はElementそのものを管理することにある
    // ref. https://zenn.dev/chooyan/articles/7c2bf39f81cbed
    setState(() {
      if (color == defaultColor) {
        color = changedColor;
      } else {
        color = defaultColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeColor,
        child: const Icon(Icons.sync),
      ),
    );
  }
}
