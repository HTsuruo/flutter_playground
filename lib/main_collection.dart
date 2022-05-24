import 'package:collection/collection.dart';
// import 'package:dartx/dartx.dart' as dartx;
import 'package:flutter_playground/logger.dart';

const unmodifiedList = <int>[1, 2, 3, 4, 5, 6];

// collectionパッケージの`sortedBy`を利用するにはComparableをimplementsしたクラスとする必要がある
class Student implements Comparable<Student> {
  Student({
    required this.name,
    required this.value,
    required this.score,
  });
  final String name;
  final int value;
  final int score;

  /// ```dart
  /// var relation = 'Dart'.compareTo('Go');
  /// logger.info(relation); // < 0
  /// relation = 'Go'.compareTo('Forward');
  /// logger.info(relation); // > 0
  /// relation = 'Forward'.compareTo('Forward');
  /// logger.info(relation); // 0
  /// ```
  @override
  int compareTo(Student other) {
    return value == other.value
        ? 0
        : value > other.value
            ? 1
            : -1;
  }
}

final students = [
  Student(name: 'taro', value: 7, score: 60),
  Student(name: 'risa', value: 1, score: 100),
  Student(name: 'mike', value: 4, score: 30),
];

void main() {
  // 要素が入っていることがわかっているIterableに対してもnullableになってしまうのが扱いづらい（`value!`）
  final max = maxBy<int, int>(unmodifiedList, (value) => value);
  logger.info('max: $max');
  final min = minBy<int, int>(unmodifiedList, (value) => value);
  logger.info('max: $min');

  // ignore: cascade_invocations
  logger.info('sum: ${unmodifiedList.sum}');

  final studentHasMaxValue = maxBy<Student, int>(
    students,
    (hoge) => hoge.value,
  );
  logger.info('studentHasMaxValue: ${studentHasMaxValue?.name}');

  // mutable
  // constのunmodifiableListだとExceptionいなる
  final modifiableList = <int>[1, 2, 3, 4, 5, 6]..sort();
  logger.info('sortedIntegerIterable: $modifiableList');

  // final sorted = students.sorted((a, b) => a.score.compareTo(b.score)).map(
  //       (e) => e.name,
  //     );
  final sorted = students.sorted((a, b) => a.score.compareTo(b.score)).map(
        (e) => e.name,
      );
  logger.info('sortedBy: $sorted');

  final sortedByDescending = students
      .sorted(
        (a, b) => -a.score.compareTo(b.score),
      )
      .map((e) => e.name);
  logger.info('sortedByDescending: $sortedByDescending');

  // Studentクラスで定義された`compareTo`メソッドがデフォルトで使われる
  // final sortedBy = students.sortedBy<Student>((e) => e).map((e) => e.name);
  // logger.info('sortedBy: $sortedBy');

  // `compareTo`に定義していないメソッドも一応指定できる
  // final sortedByCompareByScore = students
  //     .sortedByCompare<Student>((e) => e,
  //     (a, b) => a.score.compareTo(b.score))
  //     .map((e) => e.name);
  // logger.info('sortedByCompareByScore: $sortedByCompareByScore');

  // `compareTo`の判定を逆にすればDescending相当の事も一応できる
  // final sortedByCompareByScoreDescending = students
  //     .sortedByCompare<Student>((e) => e,
  //     (a, b) => -a.score.compareTo(b.score))
  //     .map((e) => e.name);
  // logger.info(
  //   'sortedByCompareByScoreDescending: $sortedByCompareByScoreDescending',
  // );

  // final sortedBy = students.sortedBy((e) => e.name)
  // .map((e) => e.name).toList();
  // logger.info('sortedBy: $sortedBy');
}

// extension on Iterable<S> {
//   Iterable<S> sortedBy(Compare Function(S element)) => sorted((a, b) =>
//   a.score.compareTo(b.score));
// T maxBy(T Function(S) orderBy) => maxBy<S, T>(this, orderBy);
// }
