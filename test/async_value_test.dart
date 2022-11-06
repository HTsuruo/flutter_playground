// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('初回読み込み成功時', () {
    const previous = AsyncLoading<int>();
    expect(previous.isLoading, isTrue);
    expect(previous.isRefreshing, isFalse);
    expect(previous.hasValue, isFalse);
    expect(previous.hasError, isFalse);
    expect(previous, isA<AsyncLoading<int>>());

    final value = const AsyncData(1).copyWithPrevious(previous);
    expect(value.isLoading, isFalse);
    expect(value.isRefreshing, isFalse);
    expect(value.hasValue, isTrue);
    expect(value.hasError, isFalse);
    expect(value, isA<AsyncData<int>>());
  });

  test('リフレッシュや監視対象の切り替えで再評価される時', () {
    const previous = AsyncData(1);
    expect(previous.isLoading, isFalse);
    expect(previous.isRefreshing, isFalse);
    expect(previous.value, 1);
    expect(previous.hasValue, isTrue);
    expect(previous.hasError, isFalse);
    expect(previous, isA<AsyncData<int>>());

    final loading = const AsyncLoading<int>().copyWithPrevious(previous);
    expect(loading.isLoading, isTrue);
    expect(loading.isRefreshing, isTrue);
    expect(loading.hasValue, isTrue);
    expect(loading.hasError, isFalse);
    expect(loading, isA<AsyncData<int>>());

    final value = const AsyncData<int>(2).copyWithPrevious(loading);
    expect(value.isLoading, isFalse);
    expect(value.isRefreshing, isFalse);
    expect(value.value, 2);
    expect(value.hasValue, isTrue);
    expect(value.hasError, isFalse);
    expect(value, isA<AsyncData<int>>());
  });

  test('初回のデータ取得後にリフレッシュした場合', () {
    const loading = AsyncLoading<int>();
    expect(loading.hasValue, isFalse);
    expect(loading.hasError, isFalse);
    expect(loading.isLoading, isTrue);
    expect(loading.isRefreshing, isFalse, reason: 'previousがないのでfalse');
    expect(loading, isA<AsyncLoading<int>>());

    final initialValue = const AsyncData(1).copyWithPrevious(loading);
    expect(initialValue.value, 1);
    expect(initialValue.hasValue, isTrue);
    expect(initialValue.hasError, isFalse);
    expect(initialValue.isLoading, isFalse);
    expect(initialValue.isRefreshing, isFalse);
    expect(initialValue, isA<AsyncData<int>>());

    final refreshing = const AsyncLoading<int>().copyWithPrevious(initialValue);
    expect(refreshing.hasValue, isTrue, reason: 'initialValueの1があるのでtrue');
    expect(refreshing.hasError, isFalse);
    expect(refreshing.isLoading, isTrue);
    expect(refreshing.isRefreshing, isTrue, reason: 'hasValueがtrueなのでtrue');
    expect(refreshing, isA<AsyncData<int>>(), reason: 'previousがAsyncDataのため');

    final value = const AsyncData<int>(2).copyWithPrevious(refreshing);
    expect(value.value, 2);
    expect(value.hasValue, isTrue);
    expect(value.hasError, isFalse);
    expect(value.isLoading, isFalse);
    expect(value.isRefreshing, isFalse);
    expect(value, isA<AsyncData<int>>());
  });

  test('isRefreshing', () {
    expect(const AsyncLoading<int>().isRefreshing, false);
    final previousIsLoading = const AsyncLoading<int>().copyWithPrevious(
      const AsyncLoading(),
    );
    expect(previousIsLoading.isRefreshing, false);
    expect(previousIsLoading, isA<AsyncLoading<int>>());

    // AsyncData
    expect(const AsyncData<int>(42).isRefreshing, false);
    final previousIsData = const AsyncLoading<int>().copyWithPrevious(
      const AsyncData<int>(42),
    );
    expect(previousIsData.isRefreshing, true);
    expect(previousIsData, isA<AsyncData<int>>());

    // AsyncError
    expect(const AsyncError<int>('err', StackTrace.empty).isRefreshing, false);
    final previousIsError = const AsyncLoading<int>().copyWithPrevious(
      const AsyncError<int>('err', StackTrace.empty),
    );
    expect(previousIsError.isRefreshing, true);
    expect(previousIsError, isA<AsyncError<int>>());
  });

  group('whenData', () {
    test('preserves isLoading/isRefreshing', () {
      expect(
        const AsyncLoading<int>()
            .copyWithPrevious(const AsyncData(42))
            .whenData((value) => value * 2),
        const AsyncLoading<int>().copyWithPrevious(const AsyncData(84)),
      );

      expect(
        const AsyncLoading<int>()
            .copyWithPrevious(const AsyncData(42))
            .whenData<String>(
              (value) => Error.throwWithStackTrace(84, StackTrace.empty),
            ),
        const AsyncLoading<String>().copyWithPrevious(
          const AsyncError(84, StackTrace.empty),
        ),
      );

      expect(
        const AsyncLoading<int>()
            .copyWithPrevious(
              const AsyncError(84, StackTrace.empty),
            )
            .whenData<String>((value) => '$value'),
        const AsyncLoading<String>().copyWithPrevious(
          const AsyncError(84, StackTrace.empty),
        ),
      );
    });
  });
}
