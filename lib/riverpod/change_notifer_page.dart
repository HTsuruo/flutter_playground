import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counter = ChangeNotifierProvider.autoDispose(
  (ref) => _Counter(),
);

class _Counter extends ChangeNotifier {
  _Counter();

  int _count = 0;
  int get count => _count;
  bool _refreshed = false;
  bool get refreshed => _refreshed;

  void increment() {
    _count++;
    notifyListeners();
  }

  void refresh() {
    _refreshed = !_refreshed;
    notifyListeners();
  }
}

class ChangeNotifierPage extends ConsumerWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  static const routeName = '/change_notifier';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(_counter.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample'),
        actions: [
          IconButton(
            onPressed: notifier.refresh,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _Text(),
            _RefreshText(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Text extends ConsumerWidget {
  const _Text({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // `select`指定することで指定のStateのみの変更を伝搬させることができる
    final count = ref.watch(_counter.select((s) => s.count));
    return Text('count: $count');
  }
}

class _RefreshText extends ConsumerWidget {
  const _RefreshText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshed = ref.watch(_counter.select((s) => s.refreshed));
    return Text('refreshed: $refreshed');
  }
}
