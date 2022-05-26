import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: 'hero',
          child: Text('タイトル'),
        ),
      ),
      body: Container(),
    );
  }
}
