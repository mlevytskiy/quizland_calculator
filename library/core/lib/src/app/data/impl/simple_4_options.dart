import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'question_option.dart';

part 'simple_4_options.g.dart';

@JsonSerializable()
class Simple4Options extends Equatable {
  @JsonKey(name: "image_file")
  final String imageFile;
  final Simple4OptionSubtype subtype;
  final String question;
  final List<QuestionOption> options;

  const Simple4Options(this.imageFile, this.question, this.options, this.subtype);

  factory Simple4Options.fromJson(Map<String, dynamic> json) => _$Simple4OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$Simple4OptionsToJson(this);

  @override
  List<Object?> get props => [imageFile, question, options];
}

enum Simple4OptionSubtype {
  @JsonValue("numbers_in_options")
  numbersInOptions,
  @JsonValue("personages_in_options")
  personagesInOptions,
  @JsonValue("text_in_options")
  textInOptions,
  @JsonValue("pick_house")
  pickHouse;
}
