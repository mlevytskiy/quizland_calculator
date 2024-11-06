import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizland_calculator/app/app.locator.dart';

import 'bloc/quiz_land_bloc.dart';
import 'bloc/quiz_land_state.dart';
import 'quiz_land_screen.dart';

class QuizLandScreenBlocWrapper extends StatelessWidget {
  const QuizLandScreenBlocWrapper({super.key});

  static QuizLandState _getScreenState() {
    bool isHarryPotterQuizlandOpened = Di.userRepository.getCache()?.isHarryPotterQuizlandOpened ?? false;
    return isHarryPotterQuizlandOpened ? QuizLandState.transformCircleToRectanglePhase1 : QuizLandState.heroMode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => QuizLandBloc(state: _getScreenState()), child: const QuizLandScreen());
  }
}
