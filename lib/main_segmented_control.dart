import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const _ToggleButton(),
          const _CustomizedToggleButton(),
          const _CupertinoSegmentedControl(),
          Container(
            height: 100,
            color: Colors.blueAccent,
            child: const CupertinoSegmentedControlCustomColor(),
          ),
        ],
      ),
    );
  }
}

/// ToggleButton Class(Material Library)
/// https://api.flutter.dev/flutter/material/ToggleButtons-class.html
class _ToggleButton extends StatefulWidget {
  const _ToggleButton({super.key});

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
      onPressed: _selected,
      isSelected: isSelected,
      children: const [
        Text('日'),
        Text('週'),
        Text('月'),
      ],
    );
  }
}

final _changeNotifierProvider = ChangeNotifierProvider(
  (ref) => ToggleController(),
);

class ToggleController extends ChangeNotifier {
  List<bool> _isSelected = [true, false];
  List<bool> get isSelected => _isSelected;

  void selected(int index) {
    _isSelected = [false, false];
    _isSelected[index] = true;
    notifyListeners();
  }
}

class _CustomizedToggleButton extends ConsumerWidget {
  const _CustomizedToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_changeNotifierProvider);

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
        onPressed: controller.selected,
        isSelected: controller.isSelected,
        children: const [
          Text('絞り込み'),
          Text('すべて'),
        ],
      ),
    );
  }
}

class _CupertinoSegmentedControl extends StatefulWidget {
  const _CupertinoSegmentedControl({super.key});

  @override
  _CupertinoSegmentedControlState createState() =>
      _CupertinoSegmentedControlState();
}

class _CupertinoSegmentedControlState
    extends State<_CupertinoSegmentedControl> {
  int groupValue = 0;

  void _selected(int? index) {
    setState(() {
      groupValue = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const map = <int, Widget>{
      0: Text('日'),
      1: Text('週'),
      2: Text('月'),
    };

    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          width: constraints.maxWidth,
          child: CupertinoSlidingSegmentedControl<int>(
            children: map,
            onValueChanged: _selected,
            groupValue: groupValue,
          ),
        ),
      ),
    );
  }
}

class CupertinoSegmentedControlCustomColor extends StatefulWidget {
  const CupertinoSegmentedControlCustomColor({super.key});
  @override
  _CupertinoSegmentedControlCustomColorState createState() =>
      _CupertinoSegmentedControlCustomColorState();
}

class _CupertinoSegmentedControlCustomColorState
    extends State<CupertinoSegmentedControlCustomColor> {
  int groupValue = 0;

  void _selected(int? index) {
    setState(() {
      groupValue = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const map = <int, Widget>{
      0: Text('日'),
      1: Text('月'),
      2: Text('年'),
    };

    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          width: constraints.maxWidth / 2,
          child: CupertinoSlidingSegmentedControl<int>(
            backgroundColor: Colors.white24,
            children: map,
            onValueChanged: _selected,
            thumbColor: Colors.white,
            groupValue: groupValue,
          ),
        ),
      ),
    );
  }
}
