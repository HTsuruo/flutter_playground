import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StreamSamplePage extends HookWidget {
  const StreamSamplePage({Key key}) : super(key: key);

  static const routeName = '/stream_sample_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Container(
        child: const Text('afa'),
      ),
    );
  }
}
