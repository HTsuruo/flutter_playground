import 'package:flutter/material.dart';

class FactorySamplePage extends StatelessWidget {
  const FactorySamplePage._({this.count, this.label});

  factory FactorySamplePage.label({required String label}) =>
      FactorySamplePage._(
        label: label,
      );

  factory FactorySamplePage.count({
    required int count,
  }) =>
      FactorySamplePage._(
        count: count,
      );

  final String? label;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FactorySamplePage'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('FactorySamplePage(label): $label'),
            Text('FactorySamplePage(count): $count'),
          ],
        ),
      ),
    );
  }
}
