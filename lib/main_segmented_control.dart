import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          Gap(16),
          _ToggleButton(),
          Gap(16),
          _CustomizedToggleButton(),
          Gap(16),
          _CupertinoSegmentedControl(),
        ],
      ),
    );
  }
}

/// ToggleButton Class(Material Library)
/// https://api.flutter.dev/flutter/material/ToggleButtons-class.html
class _ToggleButton extends StatefulWidget {
  const _ToggleButton({Key key}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<_ToggleButton> {
  List<bool> isSelected = [true, false, false];
  List<bool> get reset => isSelected.map((e) => false).toList();

  void _selected(int index) {
    setState(() {
      isSelected = reset;
      isSelected[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: const [
        Text('日足'),
        Text('週足'),
        Text('月足'),
      ],
      onPressed: _selected,
      isSelected: isSelected,
    );
  }
}

class _CustomizedToggleButton extends StatefulWidget {
  const _CustomizedToggleButton({Key key}) : super(key: key);

  @override
  _CustomizedToggleButtonState createState() => _CustomizedToggleButtonState();
}

class _CustomizedToggleButtonState extends State<_CustomizedToggleButton> {
  List<bool> isSelected = [true, false];
  List<bool> get reset => isSelected.map((e) => false).toList();

  void _selected(int index) {
    setState(() {
      isSelected = reset;
      isSelected[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ToggleButtons(
        color: Colors.amber,
        selectedColor: Colors.white,
        fillColor: Colors.amber,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        constraints: BoxConstraints(
          minWidth: (constraints.maxWidth - 80) / 2,
          minHeight: 32, //ボタンとしては非推奨だが最小高さを変えることも可
        ),
        borderRadius: BorderRadius.circular(8),
        children: const [
          Text('絞り込み'),
          Text('すべて'),
        ],
        onPressed: _selected,
        isSelected: isSelected,
      ),
    );
  }
}

class _CupertinoSegmentedControl extends StatelessWidget {
  const _CupertinoSegmentedControl({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
