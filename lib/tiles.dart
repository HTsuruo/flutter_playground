import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Tiles extends HookWidget {
  const Tiles({
    Key? key,
    required this.title,
    required this.tiles,
  }) : super(key: key);

  final String title;
  final List<ListTile> tiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => tiles[index],
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tiles.length,
      ),
    );
  }
}
