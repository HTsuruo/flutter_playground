enum FruitType {
  apple,
  orange,
  grape,
}

extension FruitTypeEx on FruitType {
  String get label {
    switch (this) {
      case FruitType.apple:
        return 'りんご';
      case FruitType.orange:
        return 'オレンジ';
      case FruitType.grape:
        return 'ぶどう';
    }
  }
}
