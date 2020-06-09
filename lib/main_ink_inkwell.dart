import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('InkWell'),
      ),
      body: const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          // ここを弄ってHot Reloadして各種Widgetがどう表示されるか見てみてください
          child: _BoxOk(),
        ),
      ),
    );
  }
}

class _BoxNg extends StatelessWidget {
  const _BoxNg({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print(runtimeType),
      // childの描画はRipple Effectの前面を覆うためベタ塗り系はそれを全部隠してしまう
      // 包むWidgetは背面に描画されていくので、現在ベタ塗りのColoredBoxですべて隠れてしまう。
      // 透過するとみえる。
      child: const ColoredBox(
        color: Colors.blue, // NG
//        color: Color.fromRGBO(255, 255, 0, 0.3), OK
      ),
    );
  }
}

class _BoxInnerBox extends StatelessWidget {
  const _BoxInnerBox({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print(runtimeType),
      // ベタ塗りした外の領域のRipple Effectは見える例
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class _BoxOk extends StatelessWidget {
  const _BoxOk({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Inkで囲ってそれで描画するのが正解
    // InkWellはタップ時に上層のInk描画を弄るイメージ
    return Ink(
      color: Colors.blue,
      child: InkWell(
        onTap: () => print(runtimeType),
      ),
    );
  }
}

class _BoxMaterial extends StatelessWidget {
  const _BoxMaterial({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // MaterialでもInkと同様だが、Ink Effect用の描画をしたいだけならInkが適切(そのためにあとから追加されたWidget)
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () => print(runtimeType),
      ),
    );
  }
}

class _BoxDecoration extends StatelessWidget {
  const _BoxDecoration({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ink(
      // 様々な描画のできるBoxDecorationで画像表示の例
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://mono0926.com/images/love_logo.png'),
        ),
      ),
      child: InkWell(
        onTap: () => print(runtimeType),
      ),
    );
  }
}

class _BoxImage extends StatelessWidget {
  const _BoxImage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 画像の場合はそれ用のコンストラクターがあって便利
    return Ink.image(
      image: const NetworkImage('https://mono0926.com/images/love_logo.png'),
      child: InkWell(
        onTap: () => print(runtimeType),
      ),
    );
  }
}
