// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      name: json['name'] as String,
      blood: json['blood'] as String,
      birthDay:
          const UnionTimestampConverter().fromJson(json['birthDay'] as Object),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
      'blood': instance.blood,
      'birthDay': const UnionTimestampConverter().toJson(instance.birthDay),
    };
