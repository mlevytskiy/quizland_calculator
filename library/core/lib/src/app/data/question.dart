import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  @JsonKey(name: "hard_level")
  final HardLevel hardLevel;
  final QuestionType type;
  final QuestionContext context;
  const Question(this.hardLevel, this.type, this.context);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object?> get props => [hardLevel, type, context];
}

@JsonSerializable()
class QuestionContext extends Equatable {
  final QuestionVideo? video;
  @JsonKey(name: "simple_4_options")
  final Simple4Options? simple4options;

  const QuestionContext(this.video, this.simple4options);

  factory QuestionContext.fromJson(Map<String, dynamic> json) => _$QuestionContextFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionContextToJson(this);

  @override
  List<Object?> get props => [video, simple4options];
}

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

@JsonSerializable()
class Simple4Options extends Equatable {
  @JsonKey(name: "image_file")
  final String imageFile;
  final String question;
  final List<QuestionOption> options;

  const Simple4Options(this.imageFile, this.question, this.options);

  factory Simple4Options.fromJson(Map<String, dynamic> json) => _$Simple4OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$Simple4OptionsToJson(this);

  @override
  List<Object?> get props => [imageFile, question, options];
}

@JsonSerializable()
class QuestionOption extends Equatable {
  @JsonKey(name: "is_right")
  final bool isRight;
  final String text;

  const QuestionOption(this.isRight, this.text);

  factory QuestionOption.fromJson(Map<String, dynamic> json) => _$QuestionOptionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionOptionToJson(this);

  @override
  List<Object?> get props => [text];
}

enum HardLevel {
  @JsonValue("1")
  easy,
  @JsonValue("2")
  middle,
  @JsonValue("3")
  hard
}

enum QuestionType {
  @JsonValue("video")
  video,
  @JsonValue("simple_4_options")
  simple4Options,
}
