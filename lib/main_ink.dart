import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

void main() => runApp(const App());

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
      appBar: AppBar(
        title: const Text('InkWell'),
      ),
      body: const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          // ここを弄ってHot Reloadして各種Widgetがどう表示されるか見てみてください
          child: _BoxCardBackground(),
        ),
      ),
    );
  }
}

class _BoxNg extends StatelessWidget {
  const _BoxNg();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => logger.info(runtimeType),
      // Ripple Effect(splash)は親のMaterialに対してかかるため、
      // child、つまりZ軸の手前側に不透明なWidgetを配置するとsplashが隠れてします。
      // 包むWidgetは背面に描画されていくので、現在ベタ塗りのColoredBoxですべて隠れてしまう。
      child: const ColoredBox(
        color: Colors.blue, // NG
        // color: Color.fromRGBO(0, 0, 255, 0.3), // OK
      ),
    );
  }
}

class _BoxInnerBox extends StatelessWidget {
  const _BoxInnerBox();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => logger.info(runtimeType),
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
  const _BoxOk();
  @override
  Widget build(BuildContext context) {
    // ColoredBoxなど不透明なWidgetの部分を
    // Inkに`代替する`ことで不透明な色を付けつつも裏側のsplashを表示することができる
    // Inkはあくまで色付け（またはDecorationやImage）Widgetの代替として使い、
    // InkWellとセットで使うことが多い。
    return InkWell(
      onTap: () => logger.info(runtimeType),
      child: Ink(
        color: Colors.blue,
      ),
    );
  }
}

class _BoxMaterialTransparency extends StatelessWidget {
  const _BoxMaterialTransparency();
  @override
  Widget build(BuildContext context) {
    // 親のMaterialとInkWellの間に不透明なWidgetがあると普通はsplashが隠れてしまう
    // 間にもう一枚Material Widget（tarnsparency）を挟むことでそれを回避できる
    return ColoredBox(
      color: Colors.blue,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => logger.info(runtimeType),
        ),
      ),
    );
  }
}

class _BoxMaterialColor extends StatelessWidget {
  const _BoxMaterialColor();
  @override
  Widget build(BuildContext context) {
    // ベタ塗りのWidgetを親に持っている場合、Inkで包んでも無効化できない
    // Materialで包んで`MaterialType.transparency`指定することで透過させて
    // ベタ塗りにSplash Effectを適用させることができる
    return ColoredBox(
      color: Colors.redAccent,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => logger.info(runtimeType),
        ),
      ),
    );
  }
}

class _BoxDecoration extends StatelessWidget {
  const _BoxDecoration();
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
        onTap: () => logger.info(runtimeType),
      ),
    );
  }
}

class _BoxImage extends StatelessWidget {
  const _BoxImage();
  @override
  Widget build(BuildContext context) {
    // 画像の場合はそれ用のコンストラクターがあって便利
    return Ink.image(
      image: const NetworkImage('https://mono0926.com/images/love_logo.png'),
      child: InkWell(
        onTap: () => logger.info(runtimeType),
      ),
    );
  }
}

class _BoxColoredBackground extends StatelessWidget {
  const _BoxColoredBackground();
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    // Inkのdecorationにあわせるためには同様の値をInkWellにも適用する必要がある
    return Ink(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => logger.info(runtimeType),
      ),
    );
  }
}

class _BoxCardBackground extends StatelessWidget {
  const _BoxCardBackground();
  @override
  Widget build(BuildContext context) {
    return Card(
      // Card WidgetにはclipBehaviorという便利なプロパティがあり
      // これを適用することで子Widgetの要素が親のCardの領域をはみ出して
      // 表示される部分を切り取ることができる。
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => logger.info(runtimeType),
      ),
    );
  }
}
