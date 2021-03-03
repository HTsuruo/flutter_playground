import 'package:flutter/cupertino.dart';

class RadioTileSelector<T> extends ChangeNotifier {
  T _groupValue;
  T get groupValue => _groupValue;

  // ignore: use_setters_to_change_properties
  void setGroupValue(T groupValue) {
    _groupValue = groupValue;
  }

  Future<void> onChange(
    BuildContext context, {
    @required T value,
  }) async {
    _groupValue = value;
    notifyListeners();
    // ラジオボタンが選択されたことがわかるようにディレイを挟んでから画面を閉じる
    await Future<void>.delayed(const Duration(milliseconds: 300));
    Navigator.pop(context, value);
  }
}
