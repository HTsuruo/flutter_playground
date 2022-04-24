import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'logger.dart';

void main() => runApp(const App());

/// `webview_flutter`と`url_launcher`のサンプル
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    final uri = Uri.https('flutter.dev', '');
    final universalLinkUri = Uri.https('twitter.com', 'h_tsuruo');
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
            onTap: () => _launchInAppBrowser(uri),
          ),
          ListTile(
            title: const Text('外部ブラウザ起動'),
            subtitle: const Text(url),
            trailing: trailingIcon,
            onTap: () => _launchExternalApplication(uri),
          ),
          ListTile(
            title: const Text('Universal Links / App Links起動'),
            subtitle: Text(universalLinkUri.toString()),
            trailing: trailingIcon,
            onTap: () => _launchExternalApplication(universalLinkUri),
          ),
        ].intersperse(const Divider()).toList(),
      ),
    );
  }

  Future<void> _launchInAppBrowser(Uri uri) async {
    await launchUrl(uri);
  }

  // Universal LinksやApp Linksの場合はアプリが起動する
  // iOSの場合（例: Appleメールアプリ）
  // info.plistに`LSApplicationQueriesSchemes`への追記が必要
  // ref. https://support.apple.com/ja-jp/guide/mdm/mdm90f60c1ce/web
  // const url = 'com.apple.mobilemail://';

  // Androidの場合（例: 電話アプリが開く）
  // Android 30以上はAndroidManifestファイルに追記が必要
  // const url = 'http://maps.google.com/maps?q=東京スカイツリー'; // Android
  Future<void> _launchExternalApplication(Uri uri) async {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _openWebView(BuildContext context, String url) async {
    final controller = Completer<WebViewController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'WebView埋め込み表示',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: colorScheme.surface,
              foregroundColor: colorScheme.onSurface,
              iconTheme: IconThemeData(color: colorScheme.onSurface),
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
