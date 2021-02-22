import 'package:flutter/material.dart';

class Sample3 extends StatelessWidget {
  const Sample3({Key key}) : super(key: key);

  static const routeName = '/nested_scroll_view/sample3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverOverlapInjectorとセットで使う
            // これがないとsnap操作でSliverAppBarでexpandedHeight指定した分が一気に展開されて
            // ListViewに覆いかぶさる形となるが、
            // SliverOverlapAbsorber``SliverOverlapInjectorを指定すると
            // スクロールに合わせて徐々に展開される挙動になる。
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('Snapping Nested SliverAppBar'),
                floating: true,
                snap: true,
                expandedHeight: 200,
                forceElevated: innerBoxIsScrolled,
              ),
            )
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              // The "controller" and "primary" members should be left
              // unset, so that the NestedScrollView can control this
              // inner scroll view.
              // If the "controller" property is set, then this scroll
              // view will not be associated with the NestedScrollView.
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverFixedExtentList(
                  itemExtent: 48,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        ListTile(title: Text('Item $index')),
                    childCount: 30,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
