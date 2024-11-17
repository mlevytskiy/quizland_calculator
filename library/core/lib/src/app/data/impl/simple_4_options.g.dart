// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_4_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Simple4Options _$Simple4OptionsFromJson(Map<String, dynamic> json) =>
    Simple4Options(
      json['image_file'] as String,
      json['question'] as String,
      (json['options'] as List<dynamic>)
          .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecode(_$Simple4OptionSubtypeEnumMap, json['subtype']),
      (json['question_lines'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Simple4OptionsToJson(Simple4Options instance) =>
    <String, dynamic>{
      'image_file': instance.imageFile,
      'subtype': _$Simple4OptionSubtypeEnumMap[instance.subtype]!,
      'question': instance.question,
      'question_lines': instance.questionLines,
      'options': instance.options,
    };

const _$Simple4OptionSubtypeEnumMap = {
  Simple4OptionSubtype.numbersInOptions: 'numbers_in_options',
  Simple4OptionSubtype.personagesInOptions: 'personages_in_options',
  Simple4OptionSubtype.textInOptions: 'text_in_options',
  Simple4OptionSubtype.pickHouse: 'pick_house',
};
