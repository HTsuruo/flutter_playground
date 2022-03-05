import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/paging/infinity_scroll_listener.dart';
import 'package:flutter_playground/paging/paging_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/iterables.dart';

final items = range(0, 100).toList();

class PagingStatefulPage extends ConsumerStatefulWidget {
  const PagingStatefulPage({Key? key}) : super(key: key);
  static const routeName = '/paging_stateful';

  @override
  _PagingStatefulPageState createState() => _PagingStatefulPageState();
}

class _PagingStatefulPageState extends ConsumerState<PagingStatefulPage> {
  bool loadMore = false;

  Future<void> fetchMore() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    setState(() {
      loadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paging'),
      ),
      body: InfinityScrollListener(
        onListener: () async {
          setState(() {
            loadMore = true;
          });
          await fetchMore();
        },
        child: ListView.separated(
          separatorBuilder: (context, _) => const Divider(),
          itemBuilder: (context, index) {
            if (loadMore && index == 19) {
              logger.info('canNext');
              return Column(
                children: [
                  ListTile(
                    title: Text('index: $index'),
                  ),
                  const PagingIndicator(),
                ],
              );
            }
            return ListTile(
              title: Text('index: $index'),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
