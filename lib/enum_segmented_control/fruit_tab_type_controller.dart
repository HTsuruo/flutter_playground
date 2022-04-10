import 'package:flutter_playground/enum_segmented_control/fruit_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fruitTabTypeController =
    StateNotifierProvider<FruitTabTypeController, FruitType>(
  (ref) => FruitTabTypeController(),
);

class FruitTabTypeController extends StateNotifier<FruitType> {
  FruitTabTypeController() : super(FruitType.apple);

  // ignore: use_setters_to_change_properties
  void select(FruitType type) {
    state = type;
  }
}
