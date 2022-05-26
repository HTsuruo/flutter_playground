import 'package:flutter/material.dart';

class AppCustomScrollView extends StatelessWidget {
  const AppCustomScrollView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            title,
            style: theme.textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.surface,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('item$index'),
            ),
          ),
        ),
      ],
    );
  }
}
