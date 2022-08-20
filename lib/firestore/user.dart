import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_converter_helper/json_converter_helper.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required String blood,
    @UnionTimestampConverter() required UnionTimestamp birthDay,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
