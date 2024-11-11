import 'package:core/src/app/app.locator.dart';
import 'package:core/src/app/utils.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/blank_widget.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/simple_4_options_widget.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';

import '../bloc/bloc.dart';
import '../quiz_land_question_param.dart';
import 'impl/impl/hero_data.dart';

class QuizLandQuestionWidget extends StatefulWidget {
  final QuizLandQuestionParam param;

  const QuizLandQuestionWidget({super.key, required this.param});

  @override
  State<QuizLandQuestionWidget> createState() => _QuizLandQuestionWidgetState();
}

class _QuizLandQuestionWidgetState extends State<QuizLandQuestionWidget> {
  bool isLocalHeroEnable = false;

  @override
  Widget build(BuildContext context) {
    Container container = widget.param.parentScreenInfo.widgetMap[widget.param.type] as Container;
    return BlocConsumerWithSideEffects<QuizLandQuestionBloc, QuizLandQuestionState, QuizLandQuestionSideEffect>(
        bloc: context.read<QuizLandQuestionBloc>(),
        sideEffectsListener: (context, sideEffect) {
          on<EnableLocalHeroModeSideEffect>(sideEffect, () {
            setState(() {
              isLocalHeroEnable = true;
            });
          });
          on<CloseScreenSideEffect>(sideEffect, () async {
            setState(() {
              isLocalHeroEnable = false;
            });
            await wait(milliseconds: 50);
            bool isCorrect = (sideEffect as CloseScreenSideEffect).isAnswerCorrect;
            Di.routeMediator.goBack(isCorrect);
          });
        },
        listener: (context, state) {},
        builder: (context, state) {
          return switch (state) {
            BlankQuizLandQuestionState _ => BlankWidget(
                textBackgroundColor: container.color!,
                heroData: HeroData.create(isLocalHeroEnable, tag: "hat", heroTag2ForText: widget.param.id),
              ),
            VideoQuizLandQuestionState state => VideoWidget(
                blocState: state,
                textBackgroundColor: container.color!,
                heroData: HeroData.create(isLocalHeroEnable, tag: "hat", heroTag2ForText: widget.param.id)),
            Simple4OptionsQuizLandQuestionState _ => const Simple4OptionsWidget(),
            // _ => const BlankWidget(questionId: "a");
          };
        });
  }

  void on<T extends QuizLandQuestionSideEffect>(QuizLandQuestionSideEffect sideEffect, VoidCallback callback) {
    if (sideEffect is T) {
      callback();
    }
  }
}
