// enum QuizLandQuestionState { blank, video, simple4Options }

import 'package:core/src/app/data/impl/pick_multiple_personages.dart';
import 'package:core/src/app/data/impl/question_video.dart';
import 'package:core/src/app/data/impl/simple_4_options.dart';

sealed class QuizLandQuestionState {}

class BlankQuizLandQuestionState extends QuizLandQuestionState {
  final BlankTypeEnum type;
  BlankQuizLandQuestionState(this.type);
}

class VideoQuizLandQuestionState extends QuizLandQuestionState {
  final QuestionVideo video;

  VideoQuizLandQuestionState({required this.video});
}

class Simple4OptionsQuizLandQuestionState extends QuizLandQuestionState {
  final Simple4Options simple4Options;

  Simple4OptionsQuizLandQuestionState({required this.simple4Options});
}

class PickMultiplePersonagesState extends QuizLandQuestionState {
  final PickMultiplePersonages pickMultiplePersonages;
  PickMultiplePersonagesState({required this.pickMultiplePersonages});
}

enum BlankTypeEnum {
  general,
  video;
}
