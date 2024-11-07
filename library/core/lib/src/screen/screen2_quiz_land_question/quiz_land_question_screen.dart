import 'package:core/src/app/app.locator.dart';
import 'package:core/src/app/route_aware_state.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/quiz_land_question_bloc.dart';
import 'package:core/src/widget/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_land_question_event.dart';
import 'quiz_land_question_param.dart';
import 'widget/quiz_land_question_local_hero_wrapper.dart';

class QuizLandQuestionScreen extends StatefulWidget {
  final ParentScreenInfo parentScreenInfo;
  const QuizLandQuestionScreen({super.key, required this.parentScreenInfo});

  @override
  State<QuizLandQuestionScreen> createState() => _QuizLandQuestionScreenState();
}

class _QuizLandQuestionScreenState extends RouteAwareState<QuizLandQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenContainer(child: QuizLandQuestionLocalHeroWrapper(parentScreenInfo: widget.parentScreenInfo));
  }

  @override
  void onEnterScreenAfterAnimation() {
    QuizLandQuestionBloc bloc = context.read<QuizLandQuestionBloc>();
    bloc.add(HeroAnimationEndEvent());
  }

  @override
  void onEnterScreenBeforeAnimation() {
    QuizLandQuestionBloc bloc = context.read<QuizLandQuestionBloc>();
    Di.readAssetsIsolate.decode('assets/harry_potter/question/${bloc.id}/info.json').then((question) {
      bloc.receiveQuestionInfoFromAssets(question);
    }).onError((_, __) {
      Di.readAssetsIsolate.decode('assets/harry_potter/question/a/info.json').then((question) {
        bloc.receiveQuestionInfoFromAssets(question);
      });
    });
  }

  @override
  void onLeaveScreen() {}
}
