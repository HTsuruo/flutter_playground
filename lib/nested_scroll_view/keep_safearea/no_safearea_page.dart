import 'package:flutter/material.dart';
import 'package:flutter_playground/nested_scroll_view/keep_safearea/app_custom_scroll_view.dart';

/// 普通にSliverAppBarの`floating:true`でスクロールすると
/// ステータスバー部分がコンテンツを覆いかぶさってしまう
class NoSafeAreaPage extends StatelessWidget {
  const NoSafeAreaPage({Key? key}) : super(key: key);

  static const routeName = '/nested_scroll_view/no_safearea_page';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: ColoredBox(
        color: Colors.lightBlueAccent,
        child: AppCustomScrollView(
          title: runtimeType.toString(),
        ),
      ),
    );
  }
}
