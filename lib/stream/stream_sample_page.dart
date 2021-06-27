import 'package:flutter/material.dart';
import 'package:flutter_playground/stream/stream_sample_page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamSamplePage extends ConsumerWidget {
  const StreamSamplePage({Key? key}) : super(key: key);

  static const routeName = '/stream_sample_page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 普通のStream/Sinkのサンプル
    ref.watch(streamSamplePageController);
    // useProvider(rxSampleController);
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Center(
        // `_StreamBuilderBaseState<T, S>`のinitStateで実際にlistenしていることから分かる通り、
        // streamデータを用意するだけで良い感じにハンドリングして描画することができるWidgetということが分かる
        child: StreamBuilder<String>(
          stream: ref.watch(streamSamplePageController).data,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Not Found');
            }
            final data = snapshot.data;
            return Text(data ?? '');
          },
        ),
      ),
    );
  }
}
