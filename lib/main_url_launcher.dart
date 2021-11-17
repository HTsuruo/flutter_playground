import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // iOSの場合（例: Appleメールアプリ）
    // info.plistに`LSApplicationQueriesSchemes`への追記が必要
    // ref. https://support.apple.com/ja-jp/guide/mdm/mdm90f60c1ce/web
    // const url = 'com.apple.mobilemail://';

    // Androidの場合（例: 電話アプリが開く）
    // Android 30以上はAndroidManifestファイルに追記が必要
    const url = 'tel://';

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: () async {
                final exist = await canLaunch(url);
                await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('canLaunch: $exist'),
                  ),
                );
              },
              child: const Text('canOpenURL'),
            ),
            OutlinedButton(
              onPressed: () async {
                await launch(url, forceSafariVC: false);
              },
              child: const Text('launch'),
            ),
          ],
        ),
      ),
    );
  }
}
