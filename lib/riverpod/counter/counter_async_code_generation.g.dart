// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_async_code_generation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $CounterHash() => r'21855a4e1205e0c7bebbae1f5766117dc8e89daa';

/// Notifierのcode generateサンプル
/// デフォルトではAutoDisposeなProviderで生成される
/// ref. https://github.com/rrousselGit/riverpod/tree/master/packages/riverpod_generator
///
/// Copied from [Counter].
final counterProvider = AutoDisposeAsyncNotifierProvider<Counter, int>(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $CounterHash,
);
typedef CounterRef = AutoDisposeAsyncNotifierProviderRef<int>;

abstract class _$Counter extends AutoDisposeAsyncNotifier<int> {
  @override
  FutureOr<int> build();
}
