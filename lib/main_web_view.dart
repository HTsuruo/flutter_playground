import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'logger.dart';

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
        child: TextButton(
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
    final controller = Completer<WebViewController>();
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
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
              onWebViewCreated: controller.complete,
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://flutter.dev/docs')) {
                  // final resURL = request.url;
                  Navigator.pop(context);
                  // TODO(tsuruoka): Navigator.popに引数を指定すると動かない
//                  Navigator.pop(context, request.url);
                  return NavigationDecision.prevent;
                }
                logger.info('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                logger.info('Page started loading: $url');
              },
              onPageFinished: (String url) {
                logger.info('Page finished loading: $url');
              },
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }
}
