import 'package:core/src/app/data/question.dart';

abstract class QuizLandQuestionEvent {}

class HeroAnimationEndEvent extends QuizLandQuestionEvent {}

class LoadingAssetsFinishedEvent extends QuizLandQuestionEvent {
  final Question question;
  LoadingAssetsFinishedEvent(this.question);
}

class PickOption extends QuizLandQuestionEvent {
  final QuestionOption option;
  PickOption(this.option);
}
