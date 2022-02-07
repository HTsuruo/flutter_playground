import 'package:flutter_playground/enum_segmented_control/fruit_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fruitTabTypeController =
    StateNotifierProvider<FruitTabTypeController, FruitType>(
  (ref) => FruitTabTypeController(ref.read),
);

class FruitTabTypeController extends StateNotifier<FruitType> {
  FruitTabTypeController(this._read) : super(FruitType.apple);
  final Reader _read;

  // ignore: use_setters_to_change_properties
  void select(FruitType type) {
    state = type;
  }
}
