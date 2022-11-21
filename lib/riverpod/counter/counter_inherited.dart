import 'package:flutter/material.dart';

/// Inherited Widgetを使ったカウンター実装
class CounterInherited extends StatefulWidget {
  const CounterInherited({super.key});

  static const routeName = '/counter/inherited';

  @override
  State<CounterInherited> createState() => _CounterInheritedState();
}

class _CounterInheritedState extends State<CounterInherited> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited Widget'),
      ),
      // 仮にここで`const`指定しなかった場合下位ツリーに変更伝搬が流れるため
      // `_Text()`が更新される様子がわかる
      body: Center(
        // `Scaffold`を包むのでも構わないåが本来は変更を伝搬したいスコープ
        // つまりこの場合は`_Text()`を包むとベター
        child: _Inherited(
          count: _counter,
          child: const _Text(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text();
  @override
  Widget build(BuildContext context) {
    // 引数を渡さずとも上位`Scaffold`を包んだ`_Inherited`にアクセスできる
    // `const`指定すると通常上位ツリーからの変更は伝搬されないので更新されないが、
    // `dependOnInheritedWidgetOfExactType`をでは変更を監視できる
    // これにより外側はしっかりconstでリビルド抑制しつつ必要なWidgetのみ変更を伝搬させることができる
    return Text('count: ${_Inherited.of(context, listen: true)!.count}');
  }
}

// 下位ツリーからのアクセスの基本は、BuildContextを使って
// InheritedWidgetでO(1)アクセスにある
class _Inherited extends InheritedWidget {
  const _Inherited({
    required super.child,
    required this.count,
  });

  final int count;

  // `dependOnInheritedWidgetOfExactType`:
  // これが呼ばれると引数に渡ってきたBuildContext(Element)が登録される
  // Widgetに変更があった時に下位ツリーのリビルドを発生させる`updateShouldNotify`次第
  // `getElementForInheritedWidgetOfExactType`:
  // 監視はせずに単に直近のInheritedWidgetのElementを取得するだけ
  static _Inherited? of(BuildContext context, {required bool listen}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_Inherited>()
      : context.getElementForInheritedWidgetOfExactType<_Inherited>()!.widget
          as _Inherited;

  // `count`が異なる場合のみ変更を伝搬する
  @override
  bool updateShouldNotify(_Inherited old) => count != old.count;

  // 例えばこのようにすると偶数のみ変更が伝搬されるので、奇数では見た目上何も起こらず
  // 偶数時のみテキストが更新される
  // bool updateShouldNotify(_Inherited old) => count.isEven;
}
