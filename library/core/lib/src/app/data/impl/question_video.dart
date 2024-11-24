import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'question_option.dart';

part 'question_video.g.dart';

@JsonSerializable()
class QuestionVideo extends Equatable {
  @JsonKey(name: "video_file")
  final String videoFile;
  @JsonKey(name: "pause_time")
  final int pauseTime;
  @JsonKey(name: "header_text")
  final String headerText;
  final List<QuestionOption> options;

  const QuestionVideo(this.videoFile, this.pauseTime, this.headerText, this.options);

  factory QuestionVideo.fromJson(Map<String, dynamic> json) => _$QuestionVideoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionVideoToJson(this);

  @override
  List<Object?> get props => [videoFile, pauseTime, headerText, options];
}
