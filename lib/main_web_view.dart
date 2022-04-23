import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'logger.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
        dividerTheme: const DividerThemeData(space: 0),
        splashFactory: InkRipple.splashFactory,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const trailingIcon = Icon(Icons.navigate_next);
    const url = 'https://flutter.dev/';
    const universalLink = 'https://twitter.com/h_tsuruo';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webページ表示の方法'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('WebView埋め込み表示'),
            subtitle: const Text(url),
            trailing: trailingIcon,
            onTap: () => _openWebView(context, url),
          ),
          ListTile(
            title: const Text('アプリ内ブラウザ起動'),
            subtitle: const Text(url),
            trailing: trailingIcon,
            onTap: () => _launchInAppBrowser(url),
          ),
          ListTile(
            title: const Text('外部ブラウザ起動'),
            subtitle: const Text(url),
            trailing: trailingIcon,
            onTap: () => _launchDefaultBrowser(url),
          ),
          ListTile(
            title: const Text('Universal Links / App Links起動'),
            subtitle: const Text(universalLink),
            trailing: trailingIcon,
            onTap: () => _launchDefaultBrowser(universalLink),
          ),
        ].intersperse(const Divider()).toList(),
      ),
    );
  }

  Future<void> _launchInAppBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    }
  }

  // Universal LinksやApp Linksの場合はアプリが起動する
  // const url = 'http://maps.google.com/maps?q=東京スカイツリー'; // Android
  // const url = 'sms:'; //iOS
  Future<void> _launchDefaultBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  Future<void> _openWebView(BuildContext context, String url) async {
    final controller = Completer<WebViewController>();
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'WebView埋め込み表示',
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
