// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionOption _$QuestionOptionFromJson(Map<String, dynamic> json) =>
    QuestionOption(
      json['is_right'] as bool,
      json['text'] as String?,
      json['image_file'] as String?,
      json['colors'] == null
          ? null
          : OptionOverrideColors.fromJson(
              json['colors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionOptionToJson(QuestionOption instance) =>
    <String, dynamic>{
      'is_right': instance.isRight,
      'text': instance.text,
      'image_file': instance.imageFile,
      'colors': instance.colors,
    };

OptionOverrideColors _$OptionOverrideColorsFromJson(
        Map<String, dynamic> json) =>
    OptionOverrideColors(
      json['color'] as String?,
      json['normalColor'] as String?,
      json['selectedColor'] as String?,
      json['disabledColor'] as String?,
      json['correctAnswerColor'] as String?,
      json['wrongAnswerColor'] as String?,
    );

Map<String, dynamic> _$OptionOverrideColorsToJson(
        OptionOverrideColors instance) =>
    <String, dynamic>{
      'color': instance.color,
      'normalColor': instance.normalColor,
      'selectedColor': instance.selectedColor,
      'disabledColor': instance.disabledColor,
      'correctAnswerColor': instance.correctAnswerColor,
      'wrongAnswerColor': instance.wrongAnswerColor,
    };
