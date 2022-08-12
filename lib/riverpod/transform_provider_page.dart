import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StreamProvider<int>((ref) => Stream.value(42));

final doubleCountLabelProvider = Provider<AsyncValue<String>>((ref) {
  return ref.watch(countProvider).whenData((value) => '${value * 2}');
});

class TransformProviderPage extends ConsumerWidget {
  const TransformProviderPage({super.key});

  static const routeName = '/transform_provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(doubleCountLabelProvider);
    // final value = ref.watch(moreTwiceProvider).value; // -> 8
    return Scaffold(
      appBar: AppBar(title: const Text('TransformProviderPage')),
      body: label.when(
        data: Text.new,
        error: (error, _) => Text(error.toString()),
        loading: CircularProgressIndicator.new,
      ),
    );
  }
}

// Stream
final initialProvider = StreamProvider<int>((ref) => Stream.value(1));

// Stream -> Future
final twiceAfterSecondProvider = FutureProvider<int>((ref) async {
  final value = await ref.watch(initialProvider.future); // -> 1
  return Future<int>.delayed(const Duration(seconds: 1), () {
    //  1 -> 2
    return value * 2;
  });
});

// Future -> AsyncValue
final twiceProvider = Provider<AsyncValue<int>>((ref) {
  final value = ref.watch(twiceAfterSecondProvider);
  return value.whenData((value) {
    //  2 -> 4
    return value * 2;
  });
});

// AsyncValue -> Stream
final moreTwiceProvider = StreamProvider<int>((ref) {
  //  4 -> 8
  return ref.watch(twiceProvider.stream).map((e) => e * 2);
});
