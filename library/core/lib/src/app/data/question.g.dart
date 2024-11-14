// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      $enumDecode(_$HardLevelEnumMap, json['hard_level']),
      $enumDecode(_$QuestionTypeEnumMap, json['type']),
      QuestionContext.fromJson(json['context'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'hard_level': _$HardLevelEnumMap[instance.hardLevel]!,
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'context': instance.context,
    };

const _$HardLevelEnumMap = {
  HardLevel.easy: '1',
  HardLevel.middle: '2',
  HardLevel.hard: '3',
};

const _$QuestionTypeEnumMap = {
  QuestionType.video: 'video',
  QuestionType.simple4Options: 'simple_4_options',
  QuestionType.pickMultiplePersonages: 'pick_multiple_personages',
};

QuestionContext _$QuestionContextFromJson(Map<String, dynamic> json) =>
    QuestionContext(
      json['video'] == null
          ? null
          : QuestionVideo.fromJson(json['video'] as Map<String, dynamic>),
      json['simple_4_options'] == null
          ? null
          : Simple4Options.fromJson(
              json['simple_4_options'] as Map<String, dynamic>),
      json['pick_multiple_personages'] == null
          ? null
          : PickMultiplePersonages.fromJson(
              json['pick_multiple_personages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionContextToJson(QuestionContext instance) =>
    <String, dynamic>{
      'video': instance.video,
      'simple_4_options': instance.simple4options,
      'pick_multiple_personages': instance.pickMultiplePersonages,
    };
