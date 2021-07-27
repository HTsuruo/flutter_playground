import 'package:flutter/material.dart';
import 'package:flutter_playground/nested_scroll_view/keep_safearea/app_custom_scroll_view.dart';

/// `SafeArea`Widgetで包んでスクロール時にステータスバーが干渉しないようにする方法
/// ステータスバーのテキストカラー（時刻や充電表示など）を指定できない
class SafeAreaWithWrapPage extends StatelessWidget {
  const SafeAreaWithWrapPage({Key? key}) : super(key: key);

  static const routeName = '/nested_scroll_view/safearea_with_wrap_page';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: ColoredBox(
          color: Colors.lightBlueAccent,
          child: AppCustomScrollView(
            title: runtimeType.toString(),
          ),
        ),
      ),
    );
  }
}
