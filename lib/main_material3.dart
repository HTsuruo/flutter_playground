import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF2E5817);
    // const seed = Color(0xFF0063d7);

    // Mediumの記事を参考に
    // ref. https://medium.com/flutter/whats-new-in-flutter-2-10-5aafb0314b12#babb
    final lightScheme = ColorScheme.fromSeed(seedColor: seed);
    // final darkScheme = ColorScheme.fromSeed(
    //   seedColor: seed,
    //   brightness: Brightness.dark,
    // );

    return MaterialApp(
      // ThemeDataのcolorSchemeSeedプロパティにColorクラスを指定するパターン
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorSchemeSeed: seed,
      // ),

      // ColorSchemeのfactoryコンストラクタ`fromSeed`を指定するパターン
      // colorSchemeをTheme算出より前に指定する使い方ができる。
      // 両者でDividerのカラーが異なる
      theme: ThemeData.from(
        colorScheme: lightScheme,
        // colorScheme: darkScheme,
      ).copyWith(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const gap = Gap(12);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Design 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('TextButton'),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Container(
                  text: 'Primary',
                  color: colorScheme.primary,
                ),
                _Container(
                  text: 'OnPrimary',
                  color: colorScheme.onPrimary,
                ),
                _Container(
                  text: 'Primary\nContainer',
                  color: colorScheme.primaryContainer,
                ),
                _Container(
                  text: 'OnPrimary\nContainer',
                  color: colorScheme.onPrimaryContainer,
                ),
              ],
            ),
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Container(
                  text: 'Secondary',
                  color: colorScheme.secondary,
                ),
                _Container(
                  text: 'OnSecondary',
                  color: colorScheme.onSecondary,
                ),
                _Container(
                  text: 'Secondary\nContainer',
                  color: colorScheme.secondaryContainer,
                ),
                _Container(
                  text: 'OnSecondary\nContainer',
                  color: colorScheme.onSecondaryContainer,
                ),
              ],
            ),
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Container(
                  text: 'Tertiary',
                  color: colorScheme.tertiary,
                ),
                _Container(
                  text: 'onTertiary',
                  color: colorScheme.onTertiary,
                ),
                _Container(
                  text: 'Tertiary\nContainer',
                  color: colorScheme.tertiaryContainer,
                ),
                _Container(
                  text: 'OnTertiary\nContainer',
                  color: colorScheme.onTertiaryContainer,
                ),
              ],
            ),
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Container(
                  text: 'Background',
                  color: colorScheme.background,
                ),
                _Container(
                  text: 'onBackground',
                  color: colorScheme.onBackground,
                ),
                _Container(
                  text: 'Surface',
                  color: colorScheme.surface,
                ),
                _Container(
                  text: 'OnSurface',
                  color: colorScheme.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const size = 60.0;
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: theme.textTheme.labelSmall!.copyWith(
            letterSpacing: 0,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(4),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: theme.dividerColor),
          ),
        ),
      ],
    );
  }
}
