import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

class StatelessSamplePage extends StatelessWidget {
  const StatelessSamplePage({Key? key}) : super(key: key);

  static const routeName = '/stateless_sample_page';

  @override
  StatelessElement createElement() {
    // Widgetの設計図を頼りに対応するElementをcreateする
    // 本来は意識することなくthisが受け渡されている
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Row(
        children: const [
          _ColorTile(color: Colors.blueAccent),
          _ColorTile(color: Colors.orange),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logger.fine('onTap'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  const _ColorTile({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 2;
    return Container(
      color: color,
      width: size,
      height: size,
    );
  }
}
