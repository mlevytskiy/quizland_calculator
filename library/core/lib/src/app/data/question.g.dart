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
    );

Map<String, dynamic> _$QuestionContextToJson(QuestionContext instance) =>
    <String, dynamic>{
      'video': instance.video,
      'simple_4_options': instance.simple4options,
    };

QuestionVideo _$QuestionVideoFromJson(Map<String, dynamic> json) =>
    QuestionVideo(
      json['video_file'] as String,
      (json['pause_time'] as num).toInt(),
      json['header_text'] as String,
      (json['options'] as List<dynamic>)
          .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionVideoToJson(QuestionVideo instance) =>
    <String, dynamic>{
      'video_file': instance.videoFile,
      'pause_time': instance.pauseTime,
      'header_text': instance.headerText,
      'options': instance.options,
    };

Simple4Options _$Simple4OptionsFromJson(Map<String, dynamic> json) =>
    Simple4Options(
      json['image_file'] as String,
      json['question'] as String,
      (json['options'] as List<dynamic>)
          .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Simple4OptionsToJson(Simple4Options instance) =>
    <String, dynamic>{
      'image_file': instance.imageFile,
      'question': instance.question,
      'options': instance.options,
    };

QuestionOption _$QuestionOptionFromJson(Map<String, dynamic> json) =>
    QuestionOption(
      json['is_right'] as bool,
      json['text'] as String,
    );

Map<String, dynamic> _$QuestionOptionToJson(QuestionOption instance) =>
    <String, dynamic>{
      'is_right': instance.isRight,
      'text': instance.text,
    };
