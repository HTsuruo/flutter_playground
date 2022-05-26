import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App({super.key});

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

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(changeNotifierProvider);

    const barItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'お知らせ'),
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

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(scrollController);

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

/// SliverAppBarとの組み合わせ
class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  static const routeName = '/notification';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(scrollController);
    return Scaffold(
        key: const PageStorageKey(routeName),
        body: CustomScrollView(
          controller: controller,
          slivers: [
            const SliverAppBar(
              title: Text('お知らせ'),
              expandedHeight: 200,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    ListTile(
                      title: Text('${index + 1}'),
                    ),
                    const Divider(),
                  ],
                ),
                childCount: 30,
              ),
            ),
          ],
        ),);
  }
}
