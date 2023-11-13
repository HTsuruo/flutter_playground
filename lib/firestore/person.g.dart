// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, use_super_parameters, duplicate_ignore
// ignore_for_file: type=lint

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class PersonCollectionReference
    implements
        PersonQuery,
        FirestoreCollectionReference<Person, PersonQuerySnapshot> {
  factory PersonCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$PersonCollectionReference;

  static Person fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Person.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Person value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Person> get reference;

  @override
  PersonDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<PersonDocumentReference> add(Person value);
}

class _$PersonCollectionReference extends _$PersonQuery
    implements PersonCollectionReference {
  factory _$PersonCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$PersonCollectionReference._(
      firestore.collection('persons').withConverter(
            fromFirestore: PersonCollectionReference.fromFirestore,
            toFirestore: PersonCollectionReference.toFirestore,
          ),
    );
  }

  _$PersonCollectionReference._(
    CollectionReference<Person> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Person> get reference =>
      super.reference as CollectionReference<Person>;

  @override
  PersonDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return PersonDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<PersonDocumentReference> add(Person value) {
    return reference.add(value).then((ref) => PersonDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$PersonCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class PersonDocumentReference
    extends FirestoreDocumentReference<Person, PersonDocumentSnapshot> {
  factory PersonDocumentReference(DocumentReference<Person> reference) =
      _$PersonDocumentReference;

  DocumentReference<Person> get reference;

  /// A reference to the [PersonCollectionReference] containing this document.
  PersonCollectionReference get parent {
    return _$PersonCollectionReference(reference.firestore);
  }

  @override
  Stream<PersonDocumentSnapshot> snapshots();

  @override
  Future<PersonDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String firstName,
    FieldValue firstNameFieldValue,
    String lastName,
    FieldValue lastNameFieldValue,
    DateTime? dateOfBirth,
    FieldValue dateOfBirthFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String firstName,
    FieldValue firstNameFieldValue,
    String lastName,
    FieldValue lastNameFieldValue,
    DateTime? dateOfBirth,
    FieldValue dateOfBirthFieldValue,
  });
}

class _$PersonDocumentReference
    extends FirestoreDocumentReference<Person, PersonDocumentSnapshot>
    implements PersonDocumentReference {
  _$PersonDocumentReference(this.reference);

  @override
  final DocumentReference<Person> reference;

  /// A reference to the [PersonCollectionReference] containing this document.
  PersonCollectionReference get parent {
    return _$PersonCollectionReference(reference.firestore);
  }

  @override
  Stream<PersonDocumentSnapshot> snapshots() {
    return reference.snapshots().map(PersonDocumentSnapshot._);
  }

  @override
  Future<PersonDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(PersonDocumentSnapshot._);
  }

  @override
  Future<PersonDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(PersonDocumentSnapshot._);
  }

  Future<void> update({
    Object? firstName = _sentinel,
    FieldValue? firstNameFieldValue,
    Object? lastName = _sentinel,
    FieldValue? lastNameFieldValue,
    Object? dateOfBirth = _sentinel,
    FieldValue? dateOfBirthFieldValue,
  }) async {
    assert(
      firstName == _sentinel || firstNameFieldValue == null,
      "Cannot specify both firstName and firstNameFieldValue",
    );
    assert(
      lastName == _sentinel || lastNameFieldValue == null,
      "Cannot specify both lastName and lastNameFieldValue",
    );
    assert(
      dateOfBirth == _sentinel || dateOfBirthFieldValue == null,
      "Cannot specify both dateOfBirth and dateOfBirthFieldValue",
    );
    final json = {
      if (firstName != _sentinel)
        _$PersonFieldMap['firstName']!:
            _$PersonPerFieldToJson.firstName(firstName as String),
      if (firstNameFieldValue != null)
        _$PersonFieldMap['firstName']!: firstNameFieldValue,
      if (lastName != _sentinel)
        _$PersonFieldMap['lastName']!:
            _$PersonPerFieldToJson.lastName(lastName as String),
      if (lastNameFieldValue != null)
        _$PersonFieldMap['lastName']!: lastNameFieldValue,
      if (dateOfBirth != _sentinel)
        _$PersonFieldMap['dateOfBirth']!:
            _$PersonPerFieldToJson.dateOfBirth(dateOfBirth as DateTime?),
      if (dateOfBirthFieldValue != null)
        _$PersonFieldMap['dateOfBirth']!: dateOfBirthFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? firstName = _sentinel,
    FieldValue? firstNameFieldValue,
    Object? lastName = _sentinel,
    FieldValue? lastNameFieldValue,
    Object? dateOfBirth = _sentinel,
    FieldValue? dateOfBirthFieldValue,
  }) {
    assert(
      firstName == _sentinel || firstNameFieldValue == null,
      "Cannot specify both firstName and firstNameFieldValue",
    );
    assert(
      lastName == _sentinel || lastNameFieldValue == null,
      "Cannot specify both lastName and lastNameFieldValue",
    );
    assert(
      dateOfBirth == _sentinel || dateOfBirthFieldValue == null,
      "Cannot specify both dateOfBirth and dateOfBirthFieldValue",
    );
    final json = {
      if (firstName != _sentinel)
        _$PersonFieldMap['firstName']!:
            _$PersonPerFieldToJson.firstName(firstName as String),
      if (firstNameFieldValue != null)
        _$PersonFieldMap['firstName']!: firstNameFieldValue,
      if (lastName != _sentinel)
        _$PersonFieldMap['lastName']!:
            _$PersonPerFieldToJson.lastName(lastName as String),
      if (lastNameFieldValue != null)
        _$PersonFieldMap['lastName']!: lastNameFieldValue,
      if (dateOfBirth != _sentinel)
        _$PersonFieldMap['dateOfBirth']!:
            _$PersonPerFieldToJson.dateOfBirth(dateOfBirth as DateTime?),
      if (dateOfBirthFieldValue != null)
        _$PersonFieldMap['dateOfBirth']!: dateOfBirthFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class PersonQuery
    implements QueryReference<Person, PersonQuerySnapshot> {
  @override
  PersonQuery limit(int limit);

  @override
  PersonQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  PersonQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  PersonQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  PersonQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PersonQuery whereFirstName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PersonQuery whereLastName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PersonQuery whereDateOfBirth({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  });

  PersonQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderByFirstName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderByLastName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderByDateOfBirth({
    bool descending = false,
    DateTime? startAt,
    DateTime? startAfter,
    DateTime? endAt,
    DateTime? endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });
}

class _$PersonQuery extends QueryReference<Person, PersonQuerySnapshot>
    implements PersonQuery {
  _$PersonQuery(
    this._collection, {
    required Query<Person> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<PersonQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(PersonQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<PersonQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(PersonQuerySnapshot._fromQuerySnapshot);
  }

  @override
  PersonQuery limit(int limit) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  PersonQuery limitToLast(int limit) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereFirstName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['firstName']!,
        isEqualTo: isEqualTo != null
            ? _$PersonPerFieldToJson.firstName(isEqualTo)
            : null,
        isNotEqualTo: isNotEqualTo != null
            ? _$PersonPerFieldToJson.firstName(isNotEqualTo)
            : null,
        isLessThan: isLessThan != null
            ? _$PersonPerFieldToJson.firstName(isLessThan)
            : null,
        isLessThanOrEqualTo: isLessThanOrEqualTo != null
            ? _$PersonPerFieldToJson.firstName(isLessThanOrEqualTo)
            : null,
        isGreaterThan: isGreaterThan != null
            ? _$PersonPerFieldToJson.firstName(isGreaterThan)
            : null,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != null
            ? _$PersonPerFieldToJson.firstName(isGreaterThanOrEqualTo)
            : null,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.firstName(e)),
        whereNotIn: whereNotIn?.map((e) => _$PersonPerFieldToJson.firstName(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereLastName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['lastName']!,
        isEqualTo: isEqualTo != null
            ? _$PersonPerFieldToJson.lastName(isEqualTo)
            : null,
        isNotEqualTo: isNotEqualTo != null
            ? _$PersonPerFieldToJson.lastName(isNotEqualTo)
            : null,
        isLessThan: isLessThan != null
            ? _$PersonPerFieldToJson.lastName(isLessThan)
            : null,
        isLessThanOrEqualTo: isLessThanOrEqualTo != null
            ? _$PersonPerFieldToJson.lastName(isLessThanOrEqualTo)
            : null,
        isGreaterThan: isGreaterThan != null
            ? _$PersonPerFieldToJson.lastName(isGreaterThan)
            : null,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != null
            ? _$PersonPerFieldToJson.lastName(isGreaterThanOrEqualTo)
            : null,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.lastName(e)),
        whereNotIn: whereNotIn?.map((e) => _$PersonPerFieldToJson.lastName(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereDateOfBirth({
    DateTime? isEqualTo,
    DateTime? isNotEqualTo,
    DateTime? isLessThan,
    DateTime? isLessThanOrEqualTo,
    DateTime? isGreaterThan,
    DateTime? isGreaterThanOrEqualTo,
    bool? isNull,
    List<DateTime?>? whereIn,
    List<DateTime?>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['dateOfBirth']!,
        isEqualTo: isEqualTo != null
            ? _$PersonPerFieldToJson.dateOfBirth(isEqualTo)
            : null,
        isNotEqualTo: isNotEqualTo != null
            ? _$PersonPerFieldToJson.dateOfBirth(isNotEqualTo)
            : null,
        isLessThan: isLessThan != null
            ? _$PersonPerFieldToJson.dateOfBirth(isLessThan)
            : null,
        isLessThanOrEqualTo: isLessThanOrEqualTo != null
            ? _$PersonPerFieldToJson.dateOfBirth(isLessThanOrEqualTo)
            : null,
        isGreaterThan: isGreaterThan != null
            ? _$PersonPerFieldToJson.dateOfBirth(isGreaterThan)
            : null,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != null
            ? _$PersonPerFieldToJson.dateOfBirth(isGreaterThanOrEqualTo)
            : null,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.dateOfBirth(e)),
        whereNotIn:
            whereNotIn?.map((e) => _$PersonPerFieldToJson.dateOfBirth(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderByFirstName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$PersonFieldMap['firstName']!, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderByLastName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$PersonFieldMap['lastName']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderByDateOfBirth({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$PersonFieldMap['dateOfBirth']!, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$PersonQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class PersonDocumentSnapshot extends FirestoreDocumentSnapshot<Person> {
  PersonDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Person> snapshot;

  @override
  PersonDocumentReference get reference {
    return PersonDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Person? data;
}

class PersonQuerySnapshot
    extends FirestoreQuerySnapshot<Person, PersonQueryDocumentSnapshot> {
  PersonQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory PersonQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Person> snapshot,
  ) {
    final docs = snapshot.docs.map(PersonQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        PersonDocumentSnapshot._,
      );
    }).toList();

    return PersonQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<PersonDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    PersonDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<PersonDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Person> snapshot;

  @override
  final List<PersonQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<PersonDocumentSnapshot>> docChanges;
}

class PersonQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Person>
    implements PersonDocumentSnapshot {
  PersonQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Person> snapshot;

  @override
  final Person data;

  @override
  PersonDocumentReference get reference {
    return PersonDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['dateOfBirth'], const FirestoreDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.dateOfBirth, const FirestoreDateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
