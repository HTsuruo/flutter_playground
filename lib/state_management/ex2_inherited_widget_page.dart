import 'package:flutter/material.dart';
import 'package:flutter_playground/state_management/main_scaffold.dart';

class Ex2InheritedWidgetPage extends StatelessWidget {
  const Ex2InheritedWidgetPage({Key? key}) : super(key: key);
  static const routeName = 'ex2_inherited_widget_page';

  @override
  Widget build(BuildContext context) {
    return _Inherited(
      child: MainScaffold(
        title: runtimeType.toString(),
        counter: 0,
        onPressed: () {},
      ),
    );
  }
}

class _Inherited extends StatelessWidget {
  const _Inherited({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
