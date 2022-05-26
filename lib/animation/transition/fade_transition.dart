import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

class FadeTransitionPage extends StatefulWidget {
  const FadeTransitionPage({super.key});

  static const routeName = '/fade_transition';

  @override
  _FadeTransitionPageState createState() => _FadeTransitionPageState();
}

class _FadeTransitionPageState extends State<FadeTransitionPage>
    with SingleTickerProviderStateMixin {
  bool _opaque = true;
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final _animation = _animationController
      .drive(
        CurveTween(
          curve: const Interval(
            0.5,
            1,
            curve: Curves.fastOutSlowIn,
          ),
        ),
      )
      .drive(
        Tween<double>(begin: 0.2, end: 1),
      );

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {
      logger.info(_animationController.value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FadeTransitionPage.routeName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _opaque
              ? _animationController.forward()
              : _animationController.reverse();
          _opaque = !_opaque;
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
