import 'package:core/core.dart';
import 'package:core/src/app/widget_extension/assets.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/quiz_land_question_bloc.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/quiz_land_question_side_effect.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/impl/hero_data.dart';
import 'package:core/src/widget/coordinate_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

import '../../bloc/quiz_land_question_state.dart';
import 'impl/hat_widget.dart';
import 'impl/personage_check_box/personage_check_box.dart';
import 'impl/personage_check_box/personages_check_box_group_controller.dart';

part 'pick_multiple_personages_widget.style.dart';

class PickMultiplePersonagesWidget extends StatefulWidget {
  final PickMultiplePersonagesState blocState;
  final HeroData heroData;
  final Color hatTextBackgroundColor;

  const PickMultiplePersonagesWidget(
      {super.key, required this.blocState, required this.heroData, required this.hatTextBackgroundColor});

  @override
  State<PickMultiplePersonagesWidget> createState() => _PickMultiplePersonagesWidgetState();
}

class _PickMultiplePersonagesWidgetState extends State<PickMultiplePersonagesWidget> {
  final CoordinateBuilder _coordinateBuilder = CoordinateBuilder()..setItemAmount(5);
  late PersonagesCheckBoxGroupController controller;
  late HatInfo hatInfo;

  @override
  void initState() {
    super.initState();
    hatInfo = HatInfo(
      Constraint(
        id: CId.hat,
        baseline: CId.headerImage.bottom,
        centerHorizontalTo: parent,
        zIndex: 12,
      ),
      widget.blocState.pickMultiplePersonages.question,
      300,
      50,
      false,
      widget.hatTextBackgroundColor,
      0.3,
    );
    controller = PersonagesCheckBoxGroupController(
        checkedColor: Colors.green,
        uncheckedColor: Colors.grey,
        amount: 5,
        answerAmount: 2,
        correctAnswers: widget.blocState.pickMultiplePersonages.options.map((item) => item.isRight).toList().asMap(),
        callback: (lastIndex, isCorrect) async {
          setState(() {
            hatInfo = fromLastPickedOption(lastIndex, isCorrect);
          });
          await wait(seconds: 1);
          setState(() {
            controller.showWrongAnswer();
          });
          await wait(milliseconds: 700);
          _bloc().emitSideEffect(CloseScreenSideEffect(isCorrect));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ConstraintLayout(
      children: [
        ConstColors.background
            .container(
                // child: widget.blocState.simple4Options.imageFile.imageAsset().center(),
                )
            .applyConstraint(
              id: CId.header,
              width: matchParent,
              height: matchConstraint,
              top: parent.top,
              bottom: CId.guideline1.top,
              zIndex: 10,
            ),
        widget.blocState.pickMultiplePersonages.imageFile.imageAsset().applyConstraint(
              id: CId.headerImage,
              top: parent.top,
              width: matchParent,
              height: wrapContent,
              zIndex: 11,
            ),
        Guideline(
          id: CId.guideline1,
          horizontal: true,
          guidelinePercent: 0.3,
        ),
        _option(0),
        _option(1),
        _option(2),
        _option(3),
        _option(4),
        ConstColors.background.container().applyConstraint(
              width: matchParent,
              height: matchConstraint,
              top: CId.guideline1.bottom,
              bottom: parent.bottom,
            ),
        HatWidget(
                isHeroEnable: widget.heroData.mode.isHeroEnable,
                isLocalHeroEnable: widget.heroData.mode.isLocalHeroEnable,
                heroTextTag: widget.heroData.heroTag2ForText,
                heroHatTag: widget.heroData.heroTag,
                localHeroTag: widget.heroData.localHeroTag,
                textBackgroundOpacity: hatInfo.opacity,
                message: hatInfo.message,
                textBackgroundColor: hatInfo.textBackgroundColor,
                textBoxWidth: hatInfo.messageWidth,
                textBoxHeight: hatInfo.messageHeight)
            .apply(constraint: hatInfo.constraint),
        Colors.black
            .withAlpha(150)
            .container()
            .padding(const EdgeInsets.only(left: 8.0, right: 8.0))
            .visible(hatInfo.showBlackBackground)
            .applyConstraint(
              top: CId.headerImage.center,
              bottom: CId.hat.bottom,
              verticalBias: 0.55,
              height: 90,
              width: matchConstraint,
              left: parent.left,
              right: parent.right,
              zIndex: 11,
            )
      ],
    );
  }

  Widget _option(int index) {
    return PersonageCheckBox(
      option: widget.blocState.pickMultiplePersonages.options[index],
      index: index,
      controller: controller,
    ).applyConstraint(
      id: CId.option(index),
      width: 100,
      height: 110,
      right: parent.right,
      left: parent.left,
      top: CId.guideline1.top,
      bottom: parent.bottom,
      verticalBias: _coordinateBuilder.get(index).y,
      horizontalBias: _coordinateBuilder.get(index).x,
      zIndex: 10,
    );
  }

  HatInfo fromLastPickedOption(int lastIndex, bool isCorrect) {
    bool isLeft = _coordinateBuilder.get(lastIndex).x > 0.5;
    ConstraintAlign? left = isLeft ? null : CId.option(lastIndex).center;
    ConstraintAlign? right = isLeft ? CId.option(lastIndex).right : null;
    Constraint constraint = Constraint(
      id: CId.hat,
      bottom: CId.option(lastIndex).bottom,
      left: left,
      right: right,
      verticalBias: 1.0,
      zIndex: 12,
    );
    String message = isCorrect ? "Correct!" : "Wrong!";
    Color textBackgroundColor = isCorrect ? Colors.green : Colors.red;
    return HatInfo(constraint, message, 100, 50, false, textBackgroundColor, 0.8);
  }

  QuizLandQuestionBloc _bloc() => context.read<QuizLandQuestionBloc>();
}

class HatInfo {
  final Constraint constraint;
  final String message;
  final double messageWidth;
  final double messageHeight;
  final bool showBlackBackground;
  final Color textBackgroundColor;
  final double opacity;
  HatInfo(this.constraint, this.message, this.messageWidth, this.messageHeight, this.showBlackBackground,
      this.textBackgroundColor, this.opacity);
}