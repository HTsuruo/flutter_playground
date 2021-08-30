import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:gap/gap.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

void main() {
  runApp(
    const App(),
  );
}

final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool show = false;
  String? code;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_positional_boolean_parameters
    void inProgress(bool loading) {
      setState(() {
        show = loading;
      });
    }

    return Barrier(
      useBoxIndicator: true,
      show: show,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: () async {
                  const callbackUrlScheme =
                      'flutter-playground://oauth-callback';
                  final url = Uri.https(
                    'github.com',
                    '/login/oauth/authorize',
                    <String, String>{
                      'client_id': 'Iv1.60d6cba1b891bd4c',
                      'redirect_uri': callbackUrlScheme,
                    },
                  );
                  try {
                    final res = await FlutterWebAuth.authenticate(
                      url: url.toString(),
                      callbackUrlScheme: callbackUrlScheme,
                    );
                    logger.info(res);
                    code = Uri.parse(res).queryParameters['code'];
                    logger.info('code: $code');
                    inProgress(true);
                    // 適当に3secほど待機
                    await Future<void>.delayed(
                      const Duration(seconds: 3),
                      () {
                        inProgress(false);
                        _scaffoldMessengerKey.currentState!.showSnackBar(
                          const SnackBar(
                            content: Text('success'),
                          ),
                        );
                      },
                    );
                  } on PlatformException catch (e) {
                    //　User canceled login
                    logger.warning(e.message);
                    _scaffoldMessengerKey.currentState!.showSnackBar(
                      SnackBar(
                        content: Text(e.message ?? 'error'),
                      ),
                    );
                  }
                },
                child: const Text('Authenticate'),
              ),
              if (code != null)
                Column(
                  children: [
                    const Gap(16),
                    Text('code: $code'),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
