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
  const App({Key key}) : super(key: key);

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
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                print('Lambda');
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
            TextButton(
              onPressed: () => onPressedCallBack(),
              child: const Text('button4: () => onPressedCallBack()'),
            ),
            TextButton(
              onPressed: () => () {
                print('lambda in lambda');
              },
              child: const Text('button5: () => (){})'),
            ),
            TextButton(
              onPressed: onPressedIntCallBack,
              child: const Text('button4: () => onPressedCallBack()'),
            ),
          ],
        ),
      ),
    );
  }
}

// これ自体がVoidCallBack = Function()
void voidFunction() {
  print('void function');
}

// VoidCallBack = Function()を返すFunction
VoidCallback onPressedCallBack() {
  print('outer');
  return () {
    print('inner');
  };
}

// intを返すFunction
// 引数は空なので`onPressed`でtear-offとして書ける
// 関数そのままを渡すイメージ
int onPressedIntCallBack() {
  print('int');
  return 1;
}
