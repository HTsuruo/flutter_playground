import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/open_container/detail.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
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
        child: _openContainers(),
      ),
    );
  }

  Widget _openContainers() {
    return ListView(
      children: [
        _openContainerWrapper(),
        _openContainerWrapper(),
        _openContainerWrapper(),
      ],
    );
  }

  OpenContainer _openContainerWrapper() {
    return OpenContainer(
      openBuilder: (context, _) {
        return const Detail();
      },
      closedElevation: 0,
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 800),
      closedBuilder: (context, _) {
        return _listTileWithDivider();
      },
    );
  }

  Widget _listTileWithDivider() {
    return Column(
      children: const [
        ListTile(
          title: Hero(
            tag: 'hero',
            child: Text('タイトル'),
          ),
          subtitle: Text('サブタイトル'),
        ),
        Divider(),
      ],
    );
  }
}
