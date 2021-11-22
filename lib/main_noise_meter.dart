import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:noise_meter/noise_meter.dart';

void main() {
  runApp(
    const App(),
  );
}

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<NoiseReading> _subscription;
  late final _noiseMeter = NoiseMeter(onError);

  void onError(Object error) {
    // TODO(tsuruoka): error handling.
    logger.warning(error);
    _subscription.cancel();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('noise_meter DEMO'),
      ),
      body: Row(
        children: [
          OutlinedButton(
            child: const Text('Start Measurement'),
            onPressed: () {
              try {
                _subscription = _noiseMeter.noiseStream.listen((noiseReading) {
                  // ここにデータが流れてくる
                  logger
                    ..info('meanDecibel: ${noiseReading.meanDecibel}')
                    ..info('maxDecibel: ${noiseReading.maxDecibel}');
                });
                // ignore: avoid_catches_without_on_clauses
              } catch (e) {
                logger.warning(e);
              }
            },
          ),
          OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () {
              _subscription.cancel();
            },
          ),
        ],
      ),
    );
  }
}
