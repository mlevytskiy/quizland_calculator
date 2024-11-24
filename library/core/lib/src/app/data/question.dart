import 'package:core/src/app/data/impl/pick_multiple_personages.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'impl/question_video.dart';
import 'impl/simple_4_options.dart';

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
  @JsonKey(name: "pick_multiple_personages")
  final PickMultiplePersonages? pickMultiplePersonages;

  const QuestionContext(this.video, this.simple4options, this.pickMultiplePersonages);

  factory QuestionContext.fromJson(Map<String, dynamic> json) => _$QuestionContextFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionContextToJson(this);

  @override
  List<Object?> get props => [video, simple4options];
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
  @JsonValue("pick_multiple_personages")
  pickMultiplePersonages,
}
