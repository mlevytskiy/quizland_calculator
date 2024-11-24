sealed class QuizLandQuestionSideEffect {}

class CloseScreenSideEffect extends QuizLandQuestionSideEffect {
  final bool isAnswerCorrect;
  CloseScreenSideEffect(this.isAnswerCorrect);
}

class EnableLocalHeroModeSideEffect extends QuizLandQuestionSideEffect {}
