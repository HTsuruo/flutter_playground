// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('初回読み込み', () {
    test('成功時', () {
      const previous = AsyncLoading<int>();
      expect(previous.hasValue, isFalse);
      expect(previous.isLoading, isTrue);
      expect(previous.isRefreshing, isFalse);
      expect(previous.hasError, isFalse);
      expect(previous, isA<AsyncLoading<int>>());

      final value = const AsyncData(1).copyWithPrevious(previous);
      expect(value.hasValue, isTrue);
      expect(value.isLoading, isFalse);
      expect(value.isRefreshing, isFalse);
      expect(value.hasError, isFalse);
      expect(previous, isA<AsyncData<int>>());
    });
  });

  group('リフレッシュや監視対象の切り替えで再評価される時', () {
    test('成功時', () {
      const previous = AsyncData(1);
      expect(previous.value, 1);
      expect(previous.hasValue, isTrue);
      expect(previous.isLoading, isFalse);
      expect(previous.isRefreshing, isFalse);
      expect(previous.hasError, isFalse);
      expect(previous, isA<AsyncData<int>>());

      final loading = const AsyncLoading<int>().copyWithPrevious(previous);
      expect(loading.hasValue, isTrue);
      expect(loading.isLoading, isTrue);
      expect(loading.isRefreshing, isTrue);
      expect(loading.hasError, isFalse);
      expect(loading, isA<AsyncData<int>>());

      final value = const AsyncData<int>(2).copyWithPrevious(loading);
      expect(value.value, 2);
      expect(value.hasValue, isTrue);
      expect(value.isLoading, isFalse);
      expect(value.isRefreshing, isFalse);
      expect(value.hasError, isFalse);
      expect(value, isA<AsyncData<int>>());
    });
  });
}
