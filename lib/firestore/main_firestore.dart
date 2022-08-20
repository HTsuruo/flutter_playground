import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
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
      ).copyWith(
        dividerTheme: const DividerThemeData(thickness: 0),
      ),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends ConsumerWidget {
  const _HomePage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.read(_usersProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Sample'),
      ),
      body: users == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: users.length,
              separatorBuilder: (context, _) => const Divider(),
              itemBuilder: (context, index) {
                final user = users[index].data();
                final birth = DateFormat.yMd().format(user.birthDay.date!);
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('blood: ${user.blood}, birth: $birth'),
                  onTap: () {
                    print('reference: ${users[index].reference.path}');
                  },
                );
              },
            ),
    );
  }
}

final _usersProvider = StreamProvider<List<QueryDocumentSnapshot<User>>>((ref) {
  return FirebaseFirestore.instance
      .collection('user')
      .withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.docs);
});
