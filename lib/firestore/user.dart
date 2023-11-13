import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_converter_helper/json_converter_helper.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Collection<User>('users')
@JsonSerializable(converters: firestoreJsonConverters)
@freezed
class User with _$User {
  const factory User({
    required String name,
    required String blood,
    @UnionTimestampConverter()
    @Default(UnionTimestamp.serverTimestamp())
    UnionTimestamp birthDay,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
