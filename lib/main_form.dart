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
      appBar: AppBar(),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            _NormalTextForm(),
            SizedBox(height: 24),
            _SizedBoxTextForm1(),
            SizedBox(height: 24),
            _SizedBoxTextForm2(),
            SizedBox(height: 24),
            _SizedBoxTextForm3(),
            SizedBox(height: 24),
            _DenseTextForm(),
            SizedBox(height: 24),
            _DenseTextForm2(),
            SizedBox(height: 24),
            _DenseTextForm3(),
          ],
        ),
      ),
    );
  }
}

class _NormalTextForm extends StatelessWidget {
  const _NormalTextForm({Key key}) : super(key: key);
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
  const _SizedBoxTextForm1({Key key}) : super(key: key);
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
  const _SizedBoxTextForm2({Key key}) : super(key: key);
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
  const _SizedBoxTextForm3({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// TextFormFieldを無理やりSizedBoxで高さを指定するとカーソルの位置が中心に合わない
      height: 44,
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        // heightを指定すると、fontSizeが大きくなった時に崩れる
        // (OS設定でtextScaleFactorによって自動的に大きくなったときなども同様)
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}

class _DenseTextForm extends StatelessWidget {
  const _DenseTextForm({Key key}) : super(key: key);
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

class _DenseTextForm2 extends StatelessWidget {
  const _DenseTextForm2({Key key}) : super(key: key);
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
          // ここで調整
          vertical: 0,
          horizontal: 12,
        ),
      ),
    );
  }
}

class _DenseTextForm3 extends StatelessWidget {
  const _DenseTextForm3({Key key}) : super(key: key);
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
