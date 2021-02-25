import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_playground/stream/stream_sample_page_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StreamSamplePage extends HookWidget {
  const StreamSamplePage({Key key}) : super(key: key);

  static const routeName = '/stream_sample_page';

  @override
  Widget build(BuildContext context) {
    // 普通のStream/Sinkのサンプル
    useProvider(streamSamplePageController);
    // useProvider(rxSampleController);
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Center(
        // `_StreamBuilderBaseState<T, S>`のinitStateで実際にlistenしていることから分かる通り、
        // streamデータを用意するだけで良い感じにハンドリングして描画することができるWidgetということが分かる
        child: StreamBuilder<String>(
          stream: useProvider(streamSamplePageController).data,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Not Found');
            }
            final data = snapshot.data;
            return Text(data);
          },
        ),
      ),
    );
  }
}
