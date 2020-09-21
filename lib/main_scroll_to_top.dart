import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: const App(),
      ),
    );

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RootPage.routeName,
      routes: {
        RootPage.routeName: (context) => const RootPage(),
        HomePage.routeName: (context) => const HomePage(),
        NotificationPage.routeName: (context) => const NotificationPage(),
      },
    );
  }
}

final changeNotifierProvider = ChangeNotifierProvider(
  (ref) => BottomTabController(0, ref.read),
);

class BottomTabController extends ChangeNotifier {
  BottomTabController(this._selectedIndex, this._read);
  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  final Reader _read;

  Future<void> onTap(int value) async {
    /// 同一タブを2回タップ（もしくはタブが選択された状態で再タップ）すると0位置に戻る
    if (_selectedIndex == value) {
      await _read(scrollController).animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
      return;
    }
    _selectedIndex = value;
    notifyListeners();
  }
}

final scrollController = Provider<ScrollController>(
  (ref) => ScrollController(),
);

class RootPage extends HookWidget {
  const RootPage({Key key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(changeNotifierProvider);

    const barItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ホーム')),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications), title: Text('お知らせ')),
    ];

    const pages = [
      HomePage(),
      NotificationPage(),
    ];

    return Scaffold(
      body: pages[controller.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: barItems,
        onTap: controller.onTap,
        currentIndex: controller.selectedIndex,
      ),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(scrollController);

    return Scaffold(
      key: const PageStorageKey(routeName),
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: ListView.builder(
        controller: controller,
        itemCount: 50,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text((index + 1).toString()),
              ),
              const Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigation),
        onPressed: () async => controller.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        ),
      ),
    );
  }
}

class NotificationPage extends HookWidget {
  const NotificationPage({Key key}) : super(key: key);

  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(scrollController);
    return Scaffold(
      key: const PageStorageKey(routeName),
      appBar: AppBar(
        title: const Text('お知らせ'),
      ),
      body: ListView.builder(
        controller: controller,
        itemCount: 50,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text('お知らせ${index + 1}'),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
