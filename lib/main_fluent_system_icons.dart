import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() => runApp(const App());

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('text_bullet_list_24_regular'),
            Gap(16),
            Icon(FluentIcons.text_bullet_list_24_regular),
            Gap(40),
            Text('text_bullet_list_ltr_24_regular'),
            Gap(16),
            Icon(FluentIcons.text_bullet_list_ltr_24_regular),
          ],
        ),
      ),
    );
  }
}
