import 'package:core/src/app/widget_extension/assets.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

import 'impl/hat_widget.dart';
import 'impl/hero_data.dart';
import 'impl/simple_option_builder.dart';
import 'impl/simple_option_widget.dart';

part 'simple_4_options_widget.style.dart';

class HatInfo {
  final Constraint constraint;
  final String message;
  final double messageWidth;
  final double messageHeight;
  final bool showBlackBackground;
  final Color textBackgroundColor;
  HatInfo(this.constraint, this.message, this.messageWidth, this.messageHeight, this.showBlackBackground,
      this.textBackgroundColor);
}

class Simple4OptionsWidgetConfiguration {
  final Simple4OptionsWidgetEnum state;
  Simple4OptionsWidgetConfiguration(this.state);
}

enum Simple4OptionsWidgetEnum {
  numbersInOptions(showHatOnFrontOfOption: false, hasSmallText: false, useCircleBackgroundForOption: true),
  personagesInOptions(hasImage: true),
  pickHouse(hasImage: true, useOnlyImageWithoutText: true, hasOverrideColors: true),
  textInOptions;

  final bool showHatOnFrontOfOption;
  final bool hasSmallText;
  final bool useCircleBackgroundForOption;
  final bool hasImage;
  final bool useOnlyImageWithoutText;
  final bool hasOverrideColors;
  const Simple4OptionsWidgetEnum(
      {this.showHatOnFrontOfOption = true,
      this.hasSmallText = true,
      this.useCircleBackgroundForOption = false,
      this.useOnlyImageWithoutText = false,
      this.hasOverrideColors = false,
      this.hasImage = false});
}

class Simple4OptionsWidget extends StatefulWidget {
  final Simple4OptionsQuizLandQuestionState blocState;
  final HeroData heroData;
  final Color textBackgroundColor;
  final Simple4OptionsWidgetConfiguration configuration;
  const Simple4OptionsWidget(
      {super.key,
      required this.blocState,
      required this.heroData,
      required this.textBackgroundColor,
      required this.configuration});

  @override
  State<Simple4OptionsWidget> createState() => _Simple4OptionsWidgetState();
}

class _Simple4OptionsWidgetState extends State<Simple4OptionsWidget> {
  Map<int, SimpleCircleOptionState> optionSelectionState = {
    0: SimpleCircleOptionState.clickable,
    1: SimpleCircleOptionState.clickable,
    2: SimpleCircleOptionState.clickable,
    3: SimpleCircleOptionState.clickable,
  };
  late HatInfo hatInfo;

  ConstraintId guideline1 = ConstraintId('guideline1');
  ConstraintId header = ConstraintId('header');
  ConstraintId headerImage = ConstraintId('headerImage');

  @override
  void initState() {
    super.initState();
    hatInfo = HatInfo(
        Constraint(
          id: cId("hat"),
          baseline: headerImage.bottom,
          centerHorizontalTo: parent,
          zIndex: 12,
        ),
        widget.blocState.simple4Options.question,
        300,
        60,
        true,
        widget.textBackgroundColor);
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
              id: header,
              width: matchParent,
              height: matchConstraint,
              top: parent.top,
              bottom: guideline1.top,
              zIndex: 10,
            ),
        widget.blocState.simple4Options.imageFile.imageAsset().applyConstraint(
              id: headerImage,
              top: parent.top,
              width: matchParent,
              height: wrapContent,
              zIndex: 11,
            ),
        Guideline(
          id: guideline1,
          horizontal: true,
          guidelinePercent: 0.3,
        ),
        _option(ConstColors.optionNormal1, ConstColors.optionSelected1, 0, guideline1,
            verticalBias: 0.2, horizontalBias: 0.2),
        _option(ConstColors.optionNormal2, ConstColors.optionSelected2, 1, guideline1,
            verticalBias: 0.3, horizontalBias: 0.8),
        _option(ConstColors.optionNormal3, ConstColors.optionSelected3, 2, guideline1,
            verticalBias: 0.5, horizontalBias: 0.35),
        _option(ConstColors.optionNormal4, ConstColors.optionSelected4, 3, guideline1,
            verticalBias: 0.7, horizontalBias: 0.7),
        ConstColors.background.container().applyConstraint(
              width: matchParent,
              height: matchConstraint,
              top: guideline1.bottom,
              bottom: parent.bottom,
            ),
        HatWidget(
                isHeroEnable: widget.heroData.mode.isHeroEnable,
                isLocalHeroEnable: widget.heroData.mode.isLocalHeroEnable,
                heroTextTag: widget.heroData.heroTag2ForText,
                heroHatTag: widget.heroData.heroTag,
                localHeroTag: widget.heroData.localHeroTag,
                textBackgroundOpacity: 0.3,
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
              top: headerImage.center,
              bottom: cId("hat").bottom,
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

  Widget _option(
    Color color,
    Color selectedColor,
    int optionIndex,
    ConstraintId guideline, {
    required double verticalBias,
    required double horizontalBias,
  }) {
    SimpleOptionBuilder builder = SimpleOptionBuilder()
      ..setBlocStateAndIndex(widget.blocState, optionIndex)
      ..setConfiguration(widget.configuration)
      ..setColors(normal: color, selected: selectedColor, disabled: ConstColors.optionDisabled)
      ..setText(
          text: widget.blocState.simple4Options.options[optionIndex].text ?? "",
          style: Style.optionText,
          smallTextStyle: Style.optionSmallText)
      ..setOptionsSelectionState(optionSelectionState)
      ..setConstraintParams(verticalBias: verticalBias, horizontalBias: horizontalBias, guideline: guideline)
      ..setOnClick((bool isCorrect, String message, Color hatTextBackgroundColor, Constraint hatConstraint) {
        setState(() {
          hatInfo = HatInfo(hatConstraint, message, 100, 50, false, hatTextBackgroundColor);
          optionSelectionState.forEach((index, value) {
            optionSelectionState[index] = (index != optionIndex)
                ? SimpleCircleOptionState.disabled
                : (isCorrect
                    ? SimpleCircleOptionState.selectedCorrectAnswer
                    : SimpleCircleOptionState.selectedWrongAnswer);
          });
        });
      });
    return builder.buildWidget().apply(constraint: builder.buildConstraint());
  }
}
