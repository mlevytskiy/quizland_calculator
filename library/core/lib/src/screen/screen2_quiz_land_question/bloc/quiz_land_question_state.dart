// enum QuizLandQuestionState { blank, video, simple4Options }

import 'package:core/src/app/data/question.dart';

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

enum BlankTypeEnum {
  general,
  video;
}
