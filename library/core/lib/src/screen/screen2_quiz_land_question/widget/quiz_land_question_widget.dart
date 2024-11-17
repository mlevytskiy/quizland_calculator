import 'package:core/src/app/app.locator.dart';
import 'package:core/src/app/data/impl/simple_4_options.dart';
import 'package:core/src/app/utils.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/blank_widget.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/simple_4_options_widget.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';

import '../bloc/bloc.dart';
import '../quiz_land_question_param.dart';
import 'impl/impl/hero_data.dart';
import 'impl/pick_multiple_personages_widget.dart';

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
    Container container = widget.param.parentScreenInfo.container;
    return BlocConsumerWithSideEffects<QuizLandQuestionBloc, QuizLandQuestionState, QuizLandQuestionSideEffect>(
        bloc: context.read<QuizLandQuestionBloc>(),
        sideEffectsListener: (context, sideEffect) {
          on<EnableLocalHeroModeSideEffect>(sideEffect, (_) {
            print("testr EnableLocalHeroModeSideEffect");
            setState(() {
              isLocalHeroEnable = true;
            });
          });
          on<CloseScreenSideEffect>(sideEffect, (sideEffect) async {
            setState(() {
              isLocalHeroEnable = false;
            });
            await wait(milliseconds: 50);
            Di.routeMediator.goBack(sideEffect.isAnswerCorrect);
          });
        },
        listener: (context, state) {},
        builder: (context, state) {
          Color color = container.color ?? Colors.transparent;
          HeroData heroData = HeroData.createHat(isLocalHeroEnable, widget.param.id);
          return switch (state) {
            BlankQuizLandQuestionState _ => BlankWidget(
                textBackgroundColor: color,
                heroData: heroData,
              ),
            VideoQuizLandQuestionState state =>
              VideoWidget(blocState: state, textBackgroundColor: color, heroData: heroData),
            Simple4OptionsQuizLandQuestionState state => Simple4OptionsWidget(
                blocState: state,
                textBackgroundColor: color,
                heroData: heroData,
                configuration: buildConfiguration(state),
              ),
            PickMultiplePersonagesState state => PickMultiplePersonagesWidget(
                hatTextBackgroundColor: color,
                blocState: state,
                heroData: heroData,
              ),
            // _ => const BlankWidget(questionId: "a");
          };
        });
  }

  void on<T extends QuizLandQuestionSideEffect>(QuizLandQuestionSideEffect sideEffect, SideEffectCallback<T> callback) {
    if (sideEffect is T) {
      callback(sideEffect);
    }
  }

  Simple4OptionsWidgetConfiguration buildConfiguration(Simple4OptionsQuizLandQuestionState state) {
    Simple4OptionsWidgetEnum widgetEnum = switch (state.simple4Options.subtype) {
      Simple4OptionSubtype.textInOptions => Simple4OptionsWidgetEnum.textInOptions,
      Simple4OptionSubtype.numbersInOptions => Simple4OptionsWidgetEnum.numbersInOptions,
      Simple4OptionSubtype.personagesInOptions => Simple4OptionsWidgetEnum.personagesInOptions,
      Simple4OptionSubtype.pickHouse => Simple4OptionsWidgetEnum.pickHouse,
    };
    return Simple4OptionsWidgetConfiguration(widgetEnum);
  }
}

typedef SideEffectCallback<T extends QuizLandQuestionSideEffect> = void Function(T sideEffect);
