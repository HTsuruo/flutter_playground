import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class FirestoreQueryBuilderPage extends ConsumerWidget {
  const FirestoreQueryBuilderPage({Key? key}) : super(key: key);

  static const routeName = '/firestore_query_builder';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paging'),
      ),
      body: FirestoreQueryBuilder(
        pageSize: 2,
        query: FirebaseFirestore.instance.collection('user'),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final users = snapshot.docs.map((d) => d.data()).toList();
              final user = users[index];
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }
              return ListTile(
                title: Text('user: $user}'),
                subtitle: Text('index: $index'),
              );
            },
            itemCount: snapshot.docs.length,
          );
        },
      ),
    );
  }
}
