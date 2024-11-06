import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizland_calculator/app/utils.dart';

import 'quiz_land_event.dart';
import 'quiz_land_state.dart';

class QuizLandBloc extends Bloc<QuizLandEvent, QuizLandState> {
  Map<String, bool?> quizResult = {};

  QuizLandBloc({QuizLandState? state}) : super(state ?? QuizLandState.heroMode) {
    on<OpenScreenFirstTime>((event, emit) async {
      emit(QuizLandState.localHeroMode);
      await wait(milliseconds: 100);
      emit(QuizLandState.transformCircleToRectanglePhase1);
      await wait(seconds: 1);
      emit(QuizLandState.showHeaderTextPhase1);
      await wait(seconds: 3);
      emit(QuizLandState.showHeaderTextPhase2AndGrid);
    });
  }
}
