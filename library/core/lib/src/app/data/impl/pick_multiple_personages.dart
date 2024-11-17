import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pick_multiple_personages.g.dart';

@JsonSerializable()
class PickMultiplePersonages extends Equatable {
  @JsonKey(name: "image_file")
  final String imageFile;
  final String question;
  @JsonKey(name: "amount_of_correct_answers")
  final int amountOfCorrectAnswers;
  @JsonKey(name: "question_black_background")
  final bool questionBlackBackground;
  final List<MPOption> options;

  const PickMultiplePersonages(this.imageFile, this.question, this.amountOfCorrectAnswers, this.options,
      {this.questionBlackBackground = false});

  factory PickMultiplePersonages.fromJson(Map<String, dynamic> json) => _$PickMultiplePersonagesFromJson(json);

  Map<String, dynamic> toJson() => _$PickMultiplePersonagesToJson(this);

  @override
  List<Object?> get props => [question];
}

@JsonSerializable()
class MPOption extends Equatable {
  final String name;
  final String avatar;

  @JsonKey(name: "is_right")
  final bool isRight;

  const MPOption(this.name, this.avatar, this.isRight);

  factory MPOption.fromJson(Map<String, dynamic> json) => _$MPOptionFromJson(json);

  Map<String, dynamic> toJson() => _$MPOptionToJson(this);

  @override
  List<Object?> get props => [name, avatar];
}
