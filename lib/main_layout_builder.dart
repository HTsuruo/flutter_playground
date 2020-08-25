import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          color: Colors.red,
          child: Column(
            children: [
              ListTile(
                title: Text('maxHeight'),
                subtitle: Text('これはScaffoldのconstraints'),
                trailing: Text('${constraints.maxHeight}'),
              ),
              LayoutBuilder(
                builder: (context, constraints) => ListTile(
                  title: Text('maxHeight'),
                  subtitle: Text('これはColumnのconstraints'),
                  trailing: Text('${constraints.maxHeight}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
