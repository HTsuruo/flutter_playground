import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';

import 'components/components.dart';

///　[DefaultTabController]を使ったパターン
/// [TabBar]と[TabBarView]のcontextの祖先となるように包むだけ
/// [TabBar]と[TabBarView]のcontrollerはそれぞれ内部的にDefaultController.ofで参照している
class DefaultTabControllerPage extends StatelessWidget {
  const DefaultTabControllerPage({Key? key}) : super(key: key);

  static const routeName = '/default_tab_controller_page';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(routeName),
          bottom: TabBar(
            tabs: tabs.map((t) => t.tab).toList(),
            onTap: (value) => logger.info('Tapped index is: $value'),
          ),
        ),
        body: TabBarView(
          children: tabs.map((t) => t.pageView).toList(),
        ),
      ),
    );
  }
}
