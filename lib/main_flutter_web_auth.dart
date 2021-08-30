import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            const callbackUrlScheme = 'flutter-playground://oauth-callback';
            final url = Uri.https(
              'github.com',
              '/login/oauth/authorize',
              <String, String>{
                'client_id': 'Iv1.60d6cba1b891bd4c',
                'redirect_uri': callbackUrlScheme,
              },
            );
            final res = await FlutterWebAuth.authenticate(
              url: url.toString(),
              callbackUrlScheme: callbackUrlScheme,
            );
            logger.info(res);
          },
          child: const Text('Authenticate'),
        ),
      ),
    );
  }
}
