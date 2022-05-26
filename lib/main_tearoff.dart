import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';

import 'logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                logger.info('Lambda');
              },
              child: const Text('button1: (){}'),
            ),
            const TextButton(
              onPressed: onPressedCallBack,
              child: Text('button2: onPressedCallBack'),
            ),
            TextButton(
              onPressed: onPressedCallBack(),
              child: const Text('button3: onPressedCallBack()'),
            ),
            const TextButton(
              onPressed: onPressedCallBack,
              child: Text('button4: () => onPressedCallBack()'),
            ),
            TextButton(
              onPressed: () => () {
                logger.info('lambda in lambda');
              },
              child: const Text('button5: () => (){})'),
            ),
            const TextButton(
              onPressed: onPressedIntCallBack,
              child: Text('button4: () => onPressedCallBack()'),
            ),
          ],
        ),
      ),
    );
  }
}

// これ自体がVoidCallBack = Function()
void voidFunction() {
  logger.info('void function');
}

// VoidCallBack = Function()を返すFunction
VoidCallback onPressedCallBack() {
  logger.info('outer');
  return () {
    logger.info('inner');
  };
}

// intを返すFunction
// 引数は空なので`onPressed`でtear-offとして書ける
// 関数そのままを渡すイメージ
int onPressedIntCallBack() {
  logger.info('int');
  return 1;
}
