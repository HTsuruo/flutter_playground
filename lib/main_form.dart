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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: const [
              _NormalTextForm(),
              SizedBox(height: 24),
              _SizedBoxTextForm1(),
              SizedBox(height: 24),
              _SizedBoxTextForm2(),
            ],
          ),
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
