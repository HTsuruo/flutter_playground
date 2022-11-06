import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({super.key});

  static const routeName = '/animated_container';

  @override
  State<AnimatedContainerPage> createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  var _isDefault = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AnimatedContainerPage.routeName),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: _isDefault ? Colors.blueAccent : Colors.orange,
            boxShadow: _isDefault
                ? const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      spreadRadius: 4,
                    ),
                  ]
                : [],
            borderRadius:
                _isDefault ? BorderRadius.circular(40) : BorderRadius.zero,
          ),
          onEnd: () {
            logger.info('animation end!!');
          },
          child: const SizedBox(
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
