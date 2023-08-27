import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore_for_file: avoid_print

void main() {
  final users = List.generate(5, (e) => e).map(
    (e) {
      final num = e + 1;
      return User(name: 'user$num', score: num * 10, pass: num * 10 >= 30);
    },
  ).toList();

  final group = groupBy<User, bool>(users, (u) => u.pass);
  final grouped = users.groupedBy((u) => u.pass);

  final foo = users.groupFoldBy<bool, User?>(
    (u) => u.pass,
    (prevSum, next) => prevSum == null ? next : prevSum + next,
  );

  test('length test', () {
    expect(group.length, 2);
    expect(grouped.length, 2);
  });
}

class User {
  User({required this.name, required this.score, required this.pass});
  String name;
  int score;
  bool pass;

  User operator +(User other) => User(
        score: score + other.score,
        name: name,
        pass: pass,
      );
}

extension CollectionX<E extends Object> on Iterable<E> {
  Map<T, List<E>> groupedBy<T>(T Function(E) key) => groupBy<E, T>(this, key);
}
