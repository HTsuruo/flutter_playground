import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/paging/paging_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'infinity_scroll_detector.dart';

class FirestoreQueryBuilderPage extends ConsumerWidget {
  const FirestoreQueryBuilderPage({Key? key}) : super(key: key);

  static const routeName = '/firestore_query_builder';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detector = ref.watch(infinityScrollDetector);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paging'),
      ),
      body: ListView.builder(
        controller: detector.scrollController,
        itemBuilder: (context, index) {
          if (detector.canNext && index == 19) {
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
    );
  }
}
