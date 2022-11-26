import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

void main() {
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const HomePage(),
    );
  }
}

enum _TabItem {
  apple(label: 'りんご'),
  orange(label: 'オレンジ'),
  grape(label: 'ぶどう'),
  ;

  const _TabItem({required this.label});
  final String label;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final _tabController = TabController(
    length: _TabItem.values.length,
    vsync: this,
  );

  var _selectedIndex = _TabItem.values.first.index;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      logger.info('selectedIndex: $_selectedIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('タブ画面移動サンプル'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: colorScheme.primary,
          tabs: _TabItem.values.mapIndexed(
            (index, tab) {
              final selected = index == _selectedIndex;
              return Tab(
                child: Text(
                  tab.label,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: selected ? colorScheme.primary : null,
                    fontWeight: selected ? FontWeight.bold : null,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _TabItem.values
            .map(
              (tab) => Center(child: Text(tab.label)),
            )
            .toList(),
      ),
    );
  }
}
