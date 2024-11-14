import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_option.g.dart';

@JsonSerializable()
class QuestionOption extends Equatable {
  @JsonKey(name: "is_right")
  final bool isRight;
  final String? text;
  @JsonKey(name: "image_file")
  final String? imageFile;

  final OptionOverrideColors? colors;

  const QuestionOption(this.isRight, this.text, this.imageFile, this.colors);

  factory QuestionOption.fromJson(Map<String, dynamic> json) => _$QuestionOptionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionOptionToJson(this);

  @override
  List<Object?> get props => [text, imageFile];
}

@JsonSerializable()
class OptionOverrideColors {
  final String? color;
  String? normalColor;
  String? selectedColor;
  final String? disabledColor;
  String? correctAnswerColor;
  String? wrongAnswerColor;
  OptionOverrideColors(this.color, this.normalColor, this.selectedColor, this.disabledColor, this.correctAnswerColor,
      this.wrongAnswerColor) {
    normalColor = normalColor ?? color;
    selectedColor = selectedColor ?? color;
    correctAnswerColor = correctAnswerColor ?? color;
    wrongAnswerColor = wrongAnswerColor ?? color;
  }

  factory OptionOverrideColors.fromJson(Map<String, dynamic> json) => _$OptionOverrideColorsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionOverrideColorsToJson(this);
}
