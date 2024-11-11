// enum QuizLandQuestionState { blank, video, simple4Options }

import 'package:core/src/app/data/question.dart';

sealed class QuizLandQuestionState {}

class BlankQuizLandQuestionState extends QuizLandQuestionState {
  final BlankTypeEnum type;
  BlankQuizLandQuestionState(this.type);
}

class VideoQuizLandQuestionState extends QuizLandQuestionState {
  final QuestionVideo video;
  QuestionOption? pickedOption;

  VideoQuizLandQuestionState({required this.video, this.pickedOption});
}

class Simple4OptionsQuizLandQuestionState extends QuizLandQuestionState {}

enum BlankTypeEnum {
  general,
  video;
}
