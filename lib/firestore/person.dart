import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(converters: firestoreJsonConverters)
class Person {
  Person({required this.firstName, required this.lastName, this.dateOfBirth});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@Collection<Person>('persons')
final personsRef = PersonCollectionReference();
