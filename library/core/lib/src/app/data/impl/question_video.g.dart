// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
