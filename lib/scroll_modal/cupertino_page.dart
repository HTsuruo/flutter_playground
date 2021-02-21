import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CupertinoPage extends HookWidget {
  const CupertinoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cupertinoPage'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('show modal'),
          onPressed: () => showCupertinoModalBottomSheet<void>(
            context: context,
            builder: (context) => Container(),
          ),
        ),
      ),
    );
  }
}
