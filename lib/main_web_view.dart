import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: const Text('launchURL'),
          onPressed: () async => _launchWebView(context),
        ),
      ),
    );
  }

  /// 有名所のアプリはURLが公開されており、launchするだけでよしなにしてくれる
  Future<void> _launchApp() async {
//    const url = 'http://maps.google.com/maps?q=東京スカイツリー'; // Android
    const url = 'sms:'; //iOS
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final error = ArgumentError('Could not launch $url');
      throw error;
    }
  }

  Future<void> _launchWebView(BuildContext context) async {
    const url = 'https://flutter.dev/';
    final _controller = Completer<WebViewController>();
    var resURL = '';
    final result = await Navigator.of(context).push(
      MaterialPageRoute<PageRoute>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'web view sample',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            body: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: _controller.complete,
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://flutter.dev/docs')) {
                  resURL = request.url;
                  Navigator.pop(context);
                  // TODO(tsuruoka): Navigator.popに引数を指定すると動かない
//                  Navigator.pop(context, request.url);
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
    print('result is $result');
    print('result is $resURL');
  }
}
