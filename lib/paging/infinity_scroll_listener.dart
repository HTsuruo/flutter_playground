import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InfinityScrollListener extends StatelessWidget {
  const InfinityScrollListener({
    Key? key,
    required this.child,
    required this.onEnd,
    this.threshold = 20,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onEnd;
  final int threshold;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final forwardScroll =
            notification.metrics.axisDirection == AxisDirection.down &&
                notification.direction == ScrollDirection.forward;
        if (forwardScroll) {
          return true;
        }
        final isScrollEnd =
            notification.metrics.maxScrollExtent - notification.metrics.pixels <
                threshold;
        if (isScrollEnd) {
          onEnd();
        }
        return true;
      },
      child: child,
    );
  }
}
