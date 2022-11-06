import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/nested_scroll_view/keep_safearea/app_custom_scroll_view.dart';

/// ScaffoldのAppBarをステータスバーとして活用してスクロール時のステータスバー干渉を防ぐケース
class SafeAreaWithTransparentAppBarPage extends StatelessWidget {
  const SafeAreaWithTransparentAppBarPage({super.key});

  static const routeName =
      '/nested_scroll_view/safearea_with_transparent_appbar_page';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      // appBarを指定することでスクロール時にステータスバーが干渉しない形にできる
      appBar: const _TransparentAppBar(),
      body: ColoredBox(
        color: Colors.lightBlueAccent,
        child: AppCustomScrollView(
          title: runtimeType.toString(),
        ),
      ),
    );
  }
}

class _TransparentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _TransparentAppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => Size.zero;
}
