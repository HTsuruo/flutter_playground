import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ref. https://flutter.dev/docs/development/accessibility-and-localization/internationalization
// ref. https://ch241.lilacwells.com/ja/articles/flutter-l10n/post/
void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}

extension on BuildContext {
  // `AppLocalizations.of(this)!`の記述が煩わしいので生やしてみた
  // `!`も1箇所に集約できて良い
  // 不要なExtension生やして元の書き方が損なわれるのは好きではないものの
  // わかりやすさ重視した
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localizations.localeOf(context).languageCode),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.helloWorld),
            Text(context.l10n.hello('TSURUOKA')),
          ],
        ),
      ),
    );
  }
}
