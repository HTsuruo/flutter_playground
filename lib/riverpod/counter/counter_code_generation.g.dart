// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_code_generation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterHash() => r'3f50cbf91494229677dc7d464f0c7c817b27398e';

/// Notifierのcode generateサンプル
/// デフォルトではAutoDisposeなProviderで生成される
/// ref. https://github.com/rrousselGit/riverpod/tree/master/packages/riverpod_generator
///
/// Copied from [Counter].
@ProviderFor(Counter)
final counterProvider = AutoDisposeNotifierProvider<Counter, int>.internal(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Counter = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
