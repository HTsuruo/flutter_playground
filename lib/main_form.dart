import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: const [
              Text('NGなやりかた'),
              Divider(),
              _NormalTextForm(),
              SizedBox(height: 24),
              _SizedBoxTextForm1(),
              SizedBox(height: 24),
              _SizedBoxTextForm2(),
              SizedBox(height: 24),
              _SizedBoxTextForm3(),
              SizedBox(height: 24),
              Text('GOODなやりかた'),
              Divider(),
              _DenseTextForm(),
              SizedBox(height: 24),
              _DenseTextForm2(),
              SizedBox(height: 24),
              _DenseTextForm3(),
              SizedBox(height: 24),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _NormalTextForm extends StatelessWidget {
  const _NormalTextForm({super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'これはラベルです',
        helperText: 'これはヘルパーテキストです',
      ),
    );
  }
}

class _SizedBoxTextForm1 extends StatelessWidget {
  const _SizedBoxTextForm1({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// TextFormFieldを無理やりSizedBoxで高さを指定するとカーソルの位置が中心に合わない
      height: 44,
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _SizedBoxTextForm2 extends StatelessWidget {
  const _SizedBoxTextForm2({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),

          /// heightを指定すると、helperText込みで44になってしまう
          /// フォーム部分だけ高さ44で、helpertextやerrorTextはその下に配置したい
          helperText: 'これはヘルパーテキストです',
        ),
      ),
    );
  }
}

class _SizedBoxTextForm3 extends StatelessWidget {
  const _SizedBoxTextForm3({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),

        /// フォントサイズを大きくしたりOS設定で変更になると
        /// height指定はそれに適応できない
        style: const TextStyle(fontSize: 44),
      ),
    );
  }
}

/// isDenseを使ったパターン：
/// 「uses less vertical space」 高さが気になる場合にサクッと修正できる
class _DenseTextForm extends StatelessWidget {
  const _DenseTextForm({super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'これはラベルです',
        helperText: 'これはヘルパーテキストです',
        // カスタマイズ性は少ないが簡単
        isDense: true,
      ),
    );
  }
}

/// contentPaddingを使ったパターン
/// isDenseより調整がきく
/// If `isOutline` property of border is true then `contentPadding` is
/// `EdgeInsets.fromLTRB(12, 20, 12, 12)` when isDense is true
/// and `EdgeInsets.fromLTRB(12, 24, 12, 16)` when isDense is false.
/// 上記のisDenseを指定するパターンだと内部的にcontentPaddingを(12, 20, 12, 12)に指定している
class _DenseTextForm2 extends StatelessWidget {
  const _DenseTextForm2({super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'これはラベルです',
        helperText: 'これはヘルパーテキストです',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
      ),
    );
  }
}

/// Themeで指定するパターン
/// フォームの高さを全て共通にする場合（ベースを用意する場合）はこれが良さそう
/// ただしフォーム以外も全体的にcompactになるのはやや懸念か
class _DenseTextForm3 extends StatelessWidget {
  const _DenseTextForm3({super.key});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // ここで調整
        // 個別に詰め気味にしたいならこのように特定Widgetだけ囲むが、
        // アプリ全体をこれで囲んで全体的に詰まり気味にもできる
        // (標準Widgetは大抵これに対応しているのでお行儀よく使っていると追従してくれる)
        visualDensity: VisualDensity.compact,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'これはラベルです',
          helperText: 'これはヘルパーテキストです',
        ),
      ),
    );
  }
}
