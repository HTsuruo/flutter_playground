import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

class PagingBuilder extends StatefulWidget {
  const PagingBuilder({
    Key? key,
    required this.child,
    required this.itemLength,
    required this.loadMore,
    this.pageSize = 10,
  }) : super(key: key);

  final Widget child;
  final int itemLength;
  final int pageSize;
  final VoidCallback loadMore;

  @override
  _PagingBuilderState createState() => _PagingBuilderState();
}

class _PagingBuilderState extends State<PagingBuilder> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    // ScrollController not attached to any scroll viewsとなるため回避
    // if (!scrollController.hasClients) {
    //   return;
    // }
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        // if (scrollController.offset >=
        //         scrollController.position.maxScrollExtent &&
        //     !scrollController.position.outOfRange) {
        logger.info('max scrolled!!');
        Future<void>.delayed(const Duration(milliseconds: 500), () {
          if (widget.itemLength == widget.pageSize) {
            widget.loadMore();
            return;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
