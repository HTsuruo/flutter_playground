import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressController = ChangeNotifierProvider(
  (ref) => ProgressController(),
);

class ProgressController extends ChangeNotifier {
  ProgressController();

  bool _inAsyncCall = false;
  bool get inAsyncCall => _inAsyncCall;

  Future<T> executeWithProgress<T>(Future<T> Function() f) async {
    try {
      _inAsyncCall = true;
      notifyListeners();
      return await f();
    } finally {
      _inAsyncCall = false;
      notifyListeners();
    }
  }
}
