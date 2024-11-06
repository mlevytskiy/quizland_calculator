import 'package:flutter/widgets.dart';
import 'package:local_hero/local_hero.dart';
import 'package:quizland_calculator/screen/screen2_quiz_land_question/quiz_land_question_param.dart';
import 'package:quizland_calculator/screen/screen2_quiz_land_question/widget/quiz_land_question_widget.dart';

typedef VoidCallback = void Function();

class QuizLandQuestionLocalHeroWrapper extends StatelessWidget {
  final ParentScreenInfo parentScreenInfo;

  const QuizLandQuestionLocalHeroWrapper({super.key, required this.parentScreenInfo});

  @override
  Widget build(BuildContext context) {
    return LocalHeroScope(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubicEmphasized,
      // curve: Curves.bounceInOut,
      child: QuizLandQuestionWidget(parentScreenInfo: parentScreenInfo),
    );
  }
}
