import 'package:flutter/material.dart';

class ListViewContent extends StatelessWidget {
  const ListViewContent({
    Key? key,
    this.controller,
    this.physics,
  }) : super(key: key);

  final ScrollController? controller;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      physics: physics,
      itemCount: 50,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            title: Text(index.toString()),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
