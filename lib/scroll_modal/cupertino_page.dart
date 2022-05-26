import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CupertinoPage extends StatelessWidget {
  const CupertinoPage({super.key});

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
