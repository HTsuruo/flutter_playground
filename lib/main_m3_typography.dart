import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('M3 Typography'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(textTheme.bodyMedium!.fontFamily!),
              _Text(label: 'Display Large', textStyle: textTheme.displayLarge),
              _Text(
                label: 'Display Medium',
                textStyle: textTheme.displayMedium,
              ),
              _Text(label: 'Display Small', textStyle: textTheme.displaySmall),
              _Text(label: 'Title Large', textStyle: textTheme.titleLarge),
              _Text(label: 'Title Medium', textStyle: textTheme.titleMedium),
              _Text(label: 'Title Small', textStyle: textTheme.titleSmall),
              _Text(label: 'Body Large', textStyle: textTheme.bodyLarge),
              _Text(label: 'Body Medium', textStyle: textTheme.bodyMedium),
              _Text(label: 'Body Small', textStyle: textTheme.bodySmall),
              _Text(label: 'Label Large', textStyle: textTheme.labelLarge),
              _Text(label: 'Label Medium', textStyle: textTheme.labelMedium),
              _Text(label: 'Label Small', textStyle: textTheme.labelSmall),
            ].intersperse(const Divider()).toList(),
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({required this.label, required this.textStyle});

  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle!;
    return Text(
      // 'あいう文字国done',
      '$label(${textStyle.fontSize}/${textStyle.letterSpacing})',
      style: textStyle,
    );
  }
}
