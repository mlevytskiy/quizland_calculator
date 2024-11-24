import 'package:core/src/screen/screen2_quiz_land_question/quiz_land_question_param.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_land_question_bloc.dart';
import 'widget/quiz_land_question_screen.dart';

class QuizLandQuestionScreenBlocWrapper extends StatelessWidget {
  final QuizLandQuestionParam param;
  const QuizLandQuestionScreenBlocWrapper({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => QuizLandQuestionBloc(),
        child: QuizLandQuestionScreen(
          param: param,
        ));
  }
}
