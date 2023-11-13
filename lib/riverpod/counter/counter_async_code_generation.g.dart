// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_async_code_generation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterHash() => r'21855a4e1205e0c7bebbae1f5766117dc8e89daa';

/// AsyncNotifierのcode generateサンプル
/// デフォルトではAutoDisposeなProviderで生成される
/// buildメソッドの返却を`FutureOr`とするとよしなにAsyncNotifierで自動生成される
///
/// Copied from [Counter].
@ProviderFor(Counter)
final counterProvider = AutoDisposeAsyncNotifierProvider<Counter, int>.internal(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Counter = AutoDisposeAsyncNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
