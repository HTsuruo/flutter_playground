import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/firebase_options.dart';
import 'package:flutter_playground/paging/firestore_query_builder_page.dart';
import 'package:flutter_playground/paging/paging_page.dart';
import 'package:flutter_playground/paging/paging_stateful_page.dart';
import 'package:flutter_playground/playground_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

Map<String, WidgetBuilder> _routes = {
  // routeName: (context) => Page Class
  PagingPage.routeName: (context) => const PagingPage(),
  PagingStatefulPage.routeName: (context) => const PagingStatefulPage(),
  FirestoreQueryBuilderPage.routeName: (context) =>
      const FirestoreQueryBuilderPage(),
};

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: PlaygroundBuilder(
        title: 'Paging',
        routes: _routes,
      ),
    );
  }
}
