// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Quizland.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuizlandSchema = Schema(
  name: r'Quizland',
  id: -7649326315655303630,
  properties: {
    r'quizlandEnum': PropertySchema(
      id: 0,
      name: r'quizlandEnum',
      type: IsarType.byte,
      enumMap: _QuizlandquizlandEnumEnumValueMap,
    )
  },
  estimateSize: _quizlandEstimateSize,
  serialize: _quizlandSerialize,
  deserialize: _quizlandDeserialize,
  deserializeProp: _quizlandDeserializeProp,
);

int _quizlandEstimateSize(
  Quizland object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _quizlandSerialize(
  Quizland object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.quizlandEnum.index);
}

Quizland _quizlandDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Quizland();
  object.quizlandEnum =
      _QuizlandquizlandEnumValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          QuizlandEnum.none;
  return object;
}

P _quizlandDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_QuizlandquizlandEnumValueEnumMap[
              reader.readByteOrNull(offset)] ??
          QuizlandEnum.none) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _QuizlandquizlandEnumEnumValueMap = {
  'none': 0,
  'harryPotter': 1,
};
const _QuizlandquizlandEnumValueEnumMap = {
  0: QuizlandEnum.none,
  1: QuizlandEnum.harryPotter,
};

extension QuizlandQueryFilter
    on QueryBuilder<Quizland, Quizland, QFilterCondition> {
  QueryBuilder<Quizland, Quizland, QAfterFilterCondition> quizlandEnumEqualTo(
      QuizlandEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizlandEnum',
        value: value,
      ));
    });
  }

  QueryBuilder<Quizland, Quizland, QAfterFilterCondition>
      quizlandEnumGreaterThan(
    QuizlandEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quizlandEnum',
        value: value,
      ));
    });
  }

  QueryBuilder<Quizland, Quizland, QAfterFilterCondition> quizlandEnumLessThan(
    QuizlandEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quizlandEnum',
        value: value,
      ));
    });
  }

  QueryBuilder<Quizland, Quizland, QAfterFilterCondition> quizlandEnumBetween(
    QuizlandEnum lower,
    QuizlandEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quizlandEnum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizlandQueryObject
    on QueryBuilder<Quizland, Quizland, QFilterCondition> {}
