import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_playground/logger.dart';

import 'components/components.dart';

///　[DefaultTabController]を使ったパターン
/// [TabBar]と[TabBarView]のcontextの祖先となるように包むだけ
/// [TabBar]と[TabBarView]のcontrollerはそれぞれ内部的にDefaultController.ofで参照している
class DefaultTabControllerPage extends HookWidget {
  const DefaultTabControllerPage({Key key}) : super(key: key);

  static const routeName = '/default_tab_controller_page';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(routeName),
          bottom: TabBar(
            tabs: tabs.entries.map((t) => t.key).toList(),
            onTap: (value) => logger.fine('Tapped index is: $value'),
          ),
        ),
        body: TabBarView(
          children: tabs.entries.map((e) => e.value).toList(),
        ),
      ),
    );
  }
}
