import 'package:flutter/material.dart';

class StatefulSamplePage extends StatefulWidget {
  const StatefulSamplePage({Key key}) : super(key: key);
  static const routeName = '/stateful_sample_page';

  @override
  StatefulElement createElement() {
    // statelessWidget同様、Widgetに対応するStatefulElementを生成する
    // 本来意識せずただthisが渡っているだけ
    return super.createElement();
  }

  // StatefulWidgetは`createState`が存在する
  // 自身のWidgetに対応するElementをcreateする他に、対応するStateもcreateしている
  // if the widget is inserted into the tree
  // in multiple locations, the framework will create a separate [State] object
  // for each location.
  // の通りで、element treeにinsertされたらその分だけ対応するStateが生成される
  // Widgetを利用する箇所に応じてその分のStateが生成されるので、1:1の関係が担保される
  // そして`createState`はthisを渡すのではなく、State Objectを継承した別クラスで定義する
  @override
  _StatefulSamplePageState createState() => _StatefulSamplePageState();
}

// StateにはLifeCycleがあり`_StateLifecycle`というenumで定義されている
// LifeCycleには4つあり、crated, initialized, ready, defunctが存在する
class _StatefulSamplePageState extends State<StatefulSamplePage> {
  int count = 0;

  @override
  void initState() {
    // _StateLifecycle.created
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _StateLifecycle.initialized
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.runtimeType.toString())),
      body: Center(
        child: Text('count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
