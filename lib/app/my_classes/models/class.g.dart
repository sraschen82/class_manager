// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClassesCollection on Isar {
  IsarCollection<Classes> get classes => this.collection();
}

const ClassesSchema = CollectionSchema(
  name: r'Classes',
  id: 3039971268103090965,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _classesEstimateSize,
  serialize: _classesSerialize,
  deserialize: _classesDeserialize,
  deserializeProp: _classesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'student': LinkSchema(
      id: 6126111497302702056,
      name: r'student',
      target: r'Student',
      single: false,
    ),
    r'discipline': LinkSchema(
      id: 2696477002218247560,
      name: r'discipline',
      target: r'Discipline',
      single: false,
      linkName: r'classes',
    )
  },
  embeddedSchemas: {},
  getId: _classesGetId,
  getLinks: _classesGetLinks,
  attach: _classesAttach,
  version: '3.1.0+1',
);

int _classesEstimateSize(
  Classes object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _classesSerialize(
  Classes object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

Classes _classesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Classes();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  return object;
}

P _classesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _classesGetId(Classes object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _classesGetLinks(Classes object) {
  return [object.student, object.discipline];
}

void _classesAttach(IsarCollection<dynamic> col, Id id, Classes object) {
  object.id = id;
  object.student.attach(col, col.isar.collection<Student>(), r'student', id);
  object.discipline
      .attach(col, col.isar.collection<Discipline>(), r'discipline', id);
}

extension ClassesQueryWhereSort on QueryBuilder<Classes, Classes, QWhere> {
  QueryBuilder<Classes, Classes, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClassesQueryWhere on QueryBuilder<Classes, Classes, QWhereClause> {
  QueryBuilder<Classes, Classes, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Classes, Classes, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Classes, Classes, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Classes, Classes, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClassesQueryFilter
    on QueryBuilder<Classes, Classes, QFilterCondition> {
  QueryBuilder<Classes, Classes, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ClassesQueryObject
    on QueryBuilder<Classes, Classes, QFilterCondition> {}

extension ClassesQueryLinks
    on QueryBuilder<Classes, Classes, QFilterCondition> {
  QueryBuilder<Classes, Classes, QAfterFilterCondition> student(
      FilterQuery<Student> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'student');
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> studentLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'student', length, true, length, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> studentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'student', 0, true, 0, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> studentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'student', 0, false, 999999, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> studentLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'student', 0, true, length, include);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition>
      studentLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'student', length, include, 999999, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> studentLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'student', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> discipline(
      FilterQuery<Discipline> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'discipline');
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> disciplineLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'discipline', length, true, length, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> disciplineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'discipline', 0, true, 0, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> disciplineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'discipline', 0, false, 999999, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition>
      disciplineLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'discipline', 0, true, length, include);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition>
      disciplineLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'discipline', length, include, 999999, true);
    });
  }

  QueryBuilder<Classes, Classes, QAfterFilterCondition> disciplineLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'discipline', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ClassesQuerySortBy on QueryBuilder<Classes, Classes, QSortBy> {
  QueryBuilder<Classes, Classes, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Classes, Classes, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ClassesQuerySortThenBy
    on QueryBuilder<Classes, Classes, QSortThenBy> {
  QueryBuilder<Classes, Classes, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Classes, Classes, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Classes, Classes, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Classes, Classes, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ClassesQueryWhereDistinct
    on QueryBuilder<Classes, Classes, QDistinct> {
  QueryBuilder<Classes, Classes, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ClassesQueryProperty
    on QueryBuilder<Classes, Classes, QQueryProperty> {
  QueryBuilder<Classes, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Classes, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
