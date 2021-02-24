import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_playground/stream/rx_sample_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StreamSamplePage extends HookWidget {
  const StreamSamplePage({Key key}) : super(key: key);

  static const routeName = '/stream_sample_page';

  @override
  Widget build(BuildContext context) {
    // 普通のStream/Sinkのサンプル
    // useProvider(streamSamplePageController);
    useProvider(rxSampleController);
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: const Center(
        child: Text('Streamの勉強'),
      ),
    );
  }
}
