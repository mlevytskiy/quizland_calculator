// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_multiple_personages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickMultiplePersonages _$PickMultiplePersonagesFromJson(
        Map<String, dynamic> json) =>
    PickMultiplePersonages(
      json['image_file'] as String,
      json['question'] as String,
      (json['amount_of_correct_answers'] as num).toInt(),
      (json['options'] as List<dynamic>)
          .map((e) => MPOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionBlackBackground:
          json['question_black_background'] as bool? ?? false,
    );

Map<String, dynamic> _$PickMultiplePersonagesToJson(
        PickMultiplePersonages instance) =>
    <String, dynamic>{
      'image_file': instance.imageFile,
      'question': instance.question,
      'amount_of_correct_answers': instance.amountOfCorrectAnswers,
      'question_black_background': instance.questionBlackBackground,
      'options': instance.options,
    };

MPOption _$MPOptionFromJson(Map<String, dynamic> json) => MPOption(
      json['name'] as String,
      json['avatar'] as String,
      json['is_right'] as bool,
    );

Map<String, dynamic> _$MPOptionToJson(MPOption instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'is_right': instance.isRight,
    };
