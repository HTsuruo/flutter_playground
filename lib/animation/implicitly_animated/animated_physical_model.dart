import 'package:flutter/material.dart';

class AnimatedPhysicalModelPage extends StatefulWidget {
  const AnimatedPhysicalModelPage({Key? key}) : super(key: key);

  static const routeName = '/animated_physical_model';

  @override
  _AnimatedPhysicalModelPageState createState() =>
      _AnimatedPhysicalModelPageState();
}

class _AnimatedPhysicalModelPageState extends State<AnimatedPhysicalModelPage> {
  var _isDefault = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AnimatedPhysicalModelPage.routeName),
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
        child: AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 500),
          shape: BoxShape.circle,
          elevation: _isDefault ? 8 : 0,
          color: Colors.orange,
          shadowColor: Colors.grey,
          child: const SizedBox(
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
