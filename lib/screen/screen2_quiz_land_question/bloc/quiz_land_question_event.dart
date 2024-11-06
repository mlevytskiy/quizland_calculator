import 'package:flutter/material.dart';

abstract class QuizLandQuestionEvent {}

class HeroAnimationEndEvent extends QuizLandQuestionEvent {}

class PickedOptionEvent extends QuizLandQuestionEvent {
  final String text;
  final int optionIndex;
  final Color color;

  PickedOptionEvent({required this.text, required this.optionIndex, required this.color});
}

class ShowIsAnswerCorrectOrNotEvent extends QuizLandQuestionEvent {
  final bool isCorrect;
  ShowIsAnswerCorrectOrNotEvent({required this.isCorrect});
}

class GoBackWithHeroAnimationEvent extends QuizLandQuestionEvent {}
