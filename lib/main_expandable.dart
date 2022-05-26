import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:simple_logger/simple_logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            _ExpandablePanel(),
            Divider(),
            _ExpandableCard(),
          ],
        ),
      ),
    );
  }
}

/// 最も簡単なExpandableの指定方法だが、Widgetのカスタマイズ性は低く制限が多い
/// 特にアイコンがHeaderの右横に配置されるのは固定ぽい
/// →Expandable, ExpandableNotifier, and ExpandableButtonを利用してカスタマイズできる
class _ExpandablePanel extends StatelessWidget {
  const _ExpandablePanel({super.key});
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: const Text('タイトル'),
      collapsed: const Text(
        '折りたたまれた状態で表示されるWidget',
      ),
      expanded: const Text(
        '展開されたときに表示されるWidget',
      ),
    );
  }
}

/// ExpandableController使うとある程度自由にカスタマイズできる
class _ExpandableCard extends StatefulWidget {
  const _ExpandableCard({super.key});

  @override
  __ExpandableCardState createState() => __ExpandableCardState();
}

class __ExpandableCardState extends State<_ExpandableCard> {
  late final ExpandableController controller = ExpandableController();

  @override
  void initState() {
    controller.addListener(() {
      logger.info(controller.value);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpandableNotifier(
        controller: controller,
        child: Expandable(
          collapsed: _CommonWidget(expanded: controller.value),
          expanded: Column(
            children: [
              _CommonWidget(expanded: controller.value),
              const Divider(height: 0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('展開されたコンテンツ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CollapsedのWidgetを共通要素として切り出して置いたほうが良さそう
/// `collapsed`な状態のWidgetと`expanded`な状態のWidgetを２つ用意するイメージで
/// WidgetをAddするような使い方ではない
class _CommonWidget extends StatelessWidget {
  const _CommonWidget({
    super.key,
    required this.expanded,
  });

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('タイトル'),
      subtitle: const Text('サブタイトル'),
      dense: true,
      trailing: ExpandableButton(
        child: Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
      ),
    );
  }
}
