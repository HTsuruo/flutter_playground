import 'package:flutter_riverpod/flutter_riverpod.dart';

final futureMock = FutureProvider.autoDispose<String>(
  (ref) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return 'Returned Value after 3sec.';
  },
);
