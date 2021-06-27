import 'package:flutter/material.dart';
import 'package:flutter_playground/nested_scroll_view/sample_1.dart';
import 'package:flutter_playground/nested_scroll_view/sample_2.dart';
import 'package:flutter_playground/nested_scroll_view/sample_3.dart';

void main() {
  return runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const _ListPage(),
      routes: {
        Sample1.routeName: (context) => const Sample1(),
        Sample2.routeName: (context) => const Sample2(),
        Sample3.routeName: (context) => const Sample3(),
      },
    );
  }
}

class _ListPage extends StatelessWidget {
  const _ListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ListTile> _tiles() {
      return [
        ListTile(
          title: const Text(Sample1.routeName),
          onTap: () => Navigator.of(context).pushNamed(Sample1.routeName),
        ),
        ListTile(
          title: const Text(Sample2.routeName),
          onTap: () => Navigator.of(context).pushNamed(Sample2.routeName),
        ),
        ListTile(
          title: const Text(Sample3.routeName),
          onTap: () => Navigator.of(context).pushNamed(Sample3.routeName),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedScrollView Sampler'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => _tiles()[index],
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _tiles().length,
      ),
    );
  }
}
