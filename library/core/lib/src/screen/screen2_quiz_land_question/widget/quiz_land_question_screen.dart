import 'package:core/src/app/app.locator.dart';
import 'package:core/src/app/route_aware_state.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/quiz_land_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';

import '../bloc/bloc.dart';
import '../quiz_land_question_param.dart';

class QuizLandQuestionScreen extends StatefulWidget {
  final QuizLandQuestionParam param;
  const QuizLandQuestionScreen({super.key, required this.param});

  @override
  State<QuizLandQuestionScreen> createState() => _QuizLandQuestionScreenState();
}

class _QuizLandQuestionScreenState extends RouteAwareState<QuizLandQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return QuizLandQuestionWidget(param: widget.param)
        .localHeroScope(duration: const Duration(seconds: 1))
        .screenContainer();
  }

  @override
  void onEnterScreenAfterAnimation() {
    _bloc().add(HeroAnimationEndEvent());
  }

  @override
  void onEnterScreenBeforeAnimation() {
    QuizLandQuestionBloc bloc = _bloc();
    Di.readAssetsIsolate
        .decode('packages/core/assets/harry_potter/question/${widget.param.id}/info.json')
        .then((question) {
      bloc.add(LoadingAssetsFinishedEvent(question));
    }).onError((_, __) {
      Di.readAssetsIsolate.decode('packages/core/assets/harry_potter/question/a/info.json').then((question) {
        bloc.add(LoadingAssetsFinishedEvent(question));
      });
    });
  }

  @override
  void onLeaveScreen() {}

  QuizLandQuestionBloc _bloc() => context.read<QuizLandQuestionBloc>();
}
