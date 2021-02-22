import 'package:flutter/material.dart';

class Sample2 extends StatelessWidget {
  const Sample2({Key key}) : super(key: key);

  static const routeName = '/nested_scroll_view/sample2';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // Setting floatHeaderSlivers to true is required in order to float
        // the outer slivers over the inner scrollable.
        // これを指定すると上スクロール時に`expandedHeight`以外の箇所が徐々に現れ、
        // 最終的にexpandedHeightが展開される形となる
        // 指定しないと、一番上までスクロールしない限りexpandedされない
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Floating Nested SliverAppBar'),
              floating: true,
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index')),
            );
          },
        ),
      ),
    );
  }
}
