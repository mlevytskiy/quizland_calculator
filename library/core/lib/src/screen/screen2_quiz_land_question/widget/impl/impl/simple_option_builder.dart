import 'package:core/core.dart';
import 'package:core/src/app/data/impl/question_option.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/bloc.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/simple_4_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

import 'simple_option_widget.dart';

class SimpleOptionBuilder {
  late Color color;
  late Color selectedColor;
  late Color disabledColor;
  Color correctAnswerColor = Colors.green;
  Color wrongAnswerColor = Colors.red;

  late String text;
  late TextStyle style;
  late TextStyle smallTextStyle;

  late VoidCallback onClick;
  late SimpleCircleOptionState state;
  late Simple4OptionsQuizLandQuestionState blocState;
  late int optionIndex;

  late double verticalBias;
  late double horizontalBias;
  late ConstraintId guideline;

  late Simple4OptionsWidgetConfiguration configuration;

  late Map<int, SimpleCircleOptionState> optionSelectionState;

  void setConfiguration(Simple4OptionsWidgetConfiguration configuration) {
    this.configuration = configuration;
  }

  void setColors({required Color normal, required Color selected, required Color disabled}) {
    color = normal;
    selectedColor = selected;
    disabledColor = disabled;
  }

  void setText({required String text, required TextStyle style, required TextStyle smallTextStyle}) {
    this.text = text;
    this.style = style;
    this.smallTextStyle = smallTextStyle;
  }

  void setBlocStateAndIndex(Simple4OptionsQuizLandQuestionState blocState, int index) {
    this.blocState = blocState;
    optionIndex = index;
  }

  void setOptionsSelectionState(Map<int, SimpleCircleOptionState> value) {
    optionSelectionState = value;
  }

  void setConstraintParams(
      {required double verticalBias, required double horizontalBias, required ConstraintId guideline}) {
    this.verticalBias = verticalBias;
    this.horizontalBias = horizontalBias;
    this.guideline = guideline;
  }

  void setOnClick(OnClickWithParams onClickWithParams) {
    bool isCorrect = blocState.simple4Options.options[optionIndex].isRight;
    String message = isCorrect ? "Correct!" : "Wrong!";
    Color textBackgroundColor = isCorrect ? Colors.green : Colors.red;
    bool isCircleMode = configuration.state.useCircleBackgroundForOption;
    Constraint rightSide;
    Constraint leftSide;
    if (isCircleMode) {
      rightSide = Constraint(
        id: cId("hat"),
        bottom: cId("$optionIndex").bottom,
        left: cId("$optionIndex").right,
        verticalBias: 1.0,
        zIndex: 12,
      );
      leftSide = Constraint(
        id: cId("hat"),
        bottom: cId("$optionIndex").bottom,
        right: cId("$optionIndex").left,
        verticalBias: 1.0,
        zIndex: 12,
      );
    } else {
      rightSide = Constraint(
        id: cId("hat"),
        baseline: cId("$optionIndex").top,
        left: cId("$optionIndex").left,
        verticalBias: 0.0,
        zIndex: 12,
      );
      leftSide = rightSide;
    }

    Constraint constraint = switch (optionIndex) {
      0 => rightSide,
      1 => leftSide,
      2 => rightSide,
      3 => leftSide,
      int() => throw UnimplementedError(),
    };
    onClick = () => onClickWithParams.call(isCorrect, message, textBackgroundColor, constraint);
  }

  SimpleOptionWidget buildWidget() {
    if (configuration.state.hasOverrideColors) {
      OptionOverrideColors? colors = blocState.simple4Options.options[optionIndex].colors;
      color = colors?.normalColor?.let((it) => it.toColor()) ?? color;
      selectedColor = colors?.selectedColor?.let((it) => it.toColor()) ?? selectedColor;
      disabledColor = colors?.disabledColor?.let((it) => it.toColor()) ?? disabledColor;
      correctAnswerColor = colors?.correctAnswerColor?.let((it) => it.toColor()) ?? correctAnswerColor;
      wrongAnswerColor = colors?.wrongAnswerColor?.let((it) => it.toColor()) ?? wrongAnswerColor;
    }
    return SimpleOptionWidget(
        state: optionSelectionState[optionIndex]!,
        color: color,
        selectedColor: selectedColor,
        disabledColor: disabledColor,
        correctAnswerColor: correctAnswerColor,
        wrongAnswerColor: wrongAnswerColor,
        text: text,
        style: configuration.state.hasSmallText ? smallTextStyle : style,
        isCircle: configuration.state.useCircleBackgroundForOption,
        onClick: onClick,
        useOnlyImageWithoutText: configuration.state.useOnlyImageWithoutText,
        imageFile: configuration.state.hasImage ? blocState.simple4Options.options[optionIndex].imageFile : null);
  }

  Constraint buildConstraint() {
    if (configuration.state.useCircleBackgroundForOption) {
      return Constraint(
        id: cId("$optionIndex"),
        width: 80,
        height: 80,
        right: parent.right,
        left: parent.left,
        top: guideline.bottom,
        bottom: parent.bottom,
        verticalBias: verticalBias,
        horizontalBias: horizontalBias,
        zIndex: 10,
      );
    } else {
      if (optionIndex == 0) {
        return Constraint(
          id: cId("$optionIndex"),
          width: matchConstraint,
          height: 150,
          right: parent.center,
          left: parent.left,
          top: guideline.bottom,
          bottom: parent.bottom,
          zIndex: 10,
          verticalBias: 0.35,
        );
      } else if (optionIndex == 1) {
        return Constraint(
          id: cId("$optionIndex"),
          width: matchConstraint,
          height: 150,
          right: parent.right,
          left: parent.center,
          top: guideline.bottom,
          bottom: parent.bottom,
          zIndex: 10,
          verticalBias: 0.35,
        );
      } else if (optionIndex == 2) {
        return Constraint(
          id: cId("$optionIndex"),
          width: matchConstraint,
          height: 150,
          right: parent.center,
          left: parent.left,
          top: cId("0").bottom,
          bottom: parent.bottom,
          zIndex: 10,
          verticalBias: 0.0,
        );
      } else if (optionIndex == 3) {
        return Constraint(
          id: cId("$optionIndex"),
          width: matchConstraint,
          height: 150,
          right: parent.right,
          left: parent.center,
          top: cId("1").bottom,
          bottom: parent.bottom,
          zIndex: 10,
          verticalBias: 0.0,
        );
      } else {
        return Constraint(
          id: cId("$optionIndex"),
          width: 80,
          height: 80,
          right: parent.center,
          left: parent.left,
          top: guideline.bottom,
          bottom: parent.bottom,
          zIndex: 10,
        );
      }
    }
  }
}

typedef OnClickWithParams = void Function(
    bool isCorrect, String message, Color hatTextBackgroundColor, Constraint hatConstraint);
