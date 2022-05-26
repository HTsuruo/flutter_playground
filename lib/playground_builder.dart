import 'package:flutter/material.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

class PlaygroundBuilder extends StatelessWidget {
  const PlaygroundBuilder({
    super.key,
    required this.title,
    required this.routes,
  });

  final String title;
  final Map<String, WidgetBuilder> routes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RoutesListView(routes: routes),
    );
  }
}
