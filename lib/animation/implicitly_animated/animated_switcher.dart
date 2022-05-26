import 'package:flutter/material.dart';

class AnimatedSwitcherPage extends StatefulWidget {
  const AnimatedSwitcherPage({super.key});

  static const routeName = '/animated_switcher';

  @override
  State<AnimatedSwitcherPage> createState() => _AnimatedSwitcherPageState();
}

class _AnimatedSwitcherPageState extends State<AnimatedSwitcherPage> {
  var _isDefault = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AnimatedSwitcherPage.routeName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isDefault = !_isDefault;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          // reverseDuration: const Duration(seconds: 2),

          // transitionBuilderでTransition系アニメーションをカスタマイズできる
          // デフォルトはFadeTransition
          // transitionBuilder: (child, animation) {
          //   return AlignTransition(
          //     alignment: animation.drive(
          //       AlignmentTween(
          //         begin: Alignment.topLeft,
          //         end: Alignment.center,
          //       ),
          //     ),
          //     child: child,
          //   );
          // },

          // 新旧Widgetの配置もカスタマイズできる
          // デフォルトはStackかつCenter
          // layoutBuilder: (child, previousChildren) {
          //   return Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       if (child != null) child,
          //       ...previousChildren,
          //     ],
          //   );
          // },
          child: _isDefault ? const HogeBox() : const PiyoBox(),
        ),
      ),
    );
  }
}

class HogeBox extends StatelessWidget {
  const HogeBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.blueAccent,
    );
  }
}

class PiyoBox extends StatelessWidget {
  const PiyoBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.orange,
    );
  }
}
