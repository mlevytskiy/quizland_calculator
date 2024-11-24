import 'package:flutter/material.dart';

class PersonagesCheckBoxGroupController {
  final int amount;
  final int answerAmount;
  Map<int, ItemState> personagesMap = {};
  final Map<int, bool> correctAnswers;

  final Color checkedColor;
  final Color uncheckedColor;
  final PickedOptionResult callback;

  PersonagesCheckBoxGroupController(
      {required this.checkedColor,
      required this.uncheckedColor,
      required this.amount,
      required this.answerAmount,
      required this.correctAnswers,
      required this.callback}) {
    for (int i = 0; i < amount; i++) {
      _uncheck(i);
    }
  }

  PersonageCheckState getUIState(int index) {
    return personagesMap[index]!.state;
  }

  void onClick(int index) {
    PersonageCheckBoxLogicState logicState = personagesMap[index]!.logicState;
    if (logicState.isChecked) {
      _uncheck(index);
    } else {
      _check(index);
      bool shouldDisabled = _shouldWeDisableAllItems();
      if (shouldDisabled) {
        _disableAllItems();
        callback.call(index, _isCorrectAnswer());
      }
    }
  }

  void showWrongAnswer() {
    for (int i = 0; i < amount; i++) {
      if (personagesMap[i]!.logicState.isChecked) {
        PersonageCheckBoxLogicState logicState = correctAnswers[i]!
            ? PersonageCheckBoxLogicState.checkedDisabledCorrectAnswer
            : PersonageCheckBoxLogicState.checkedDisabledWrongAnswer;
        personagesMap[i] = ItemState(logicState: logicState, state: _fromLogicState(logicState));
      }
    }
  }

  void _disableAllItems() {
    for (int i = 0; i < amount; i++) {
      PersonageCheckBoxLogicState logicState = (personagesMap[i]!.logicState.isChecked)
          ? PersonageCheckBoxLogicState.checkedAndDisabled
          : PersonageCheckBoxLogicState.disabledUnchecked;
      personagesMap[i] = ItemState(logicState: logicState, state: _fromLogicState(logicState));
    }
  }

  bool _shouldWeDisableAllItems() {
    int amountCheckedItems = 0;
    for (int i = 0; i < amount; i++) {
      if (personagesMap[i]!.logicState.isChecked) {
        amountCheckedItems++;
      }
    }
    return amountCheckedItems >= answerAmount;
  }

  bool _isCorrectAnswer() {
    for (int i = 0; i < amount; i++) {
      if (personagesMap[i]!.logicState.isChecked) {
        if (!correctAnswers[i]!) {
          return false;
        }
      }
    }
    return true;
  }

  void _check(int index) {
    PersonageCheckBoxLogicState logicState = PersonageCheckBoxLogicState.checked;
    personagesMap[index] = ItemState(logicState: logicState, state: _fromLogicState(logicState));
  }

  void _uncheck(int index) {
    PersonageCheckBoxLogicState logicState = PersonageCheckBoxLogicState.normal;
    personagesMap[index] = ItemState(logicState: logicState, state: _fromLogicState(logicState));
  }

  PersonageCheckState _fromLogicState(PersonageCheckBoxLogicState logicState) {
    return switch (logicState) {
      PersonageCheckBoxLogicState.normal => PersonageCheckState(
          isChecked: false, borderColor: uncheckedColor, checkBoxColor: uncheckedColor, checkColor: Colors.white),
      PersonageCheckBoxLogicState.checked => PersonageCheckState(
          isChecked: true, borderColor: checkedColor, checkBoxColor: checkedColor, checkColor: Colors.white),
      PersonageCheckBoxLogicState.checkedAndDisabled => PersonageCheckState(
          isChecked: true,
          borderColor: checkedColor,
          checkBoxColor: checkedColor,
          checkColor: Colors.white,
          isDisable: true),
      PersonageCheckBoxLogicState.disabledUnchecked => PersonageCheckState(
          isChecked: false,
          borderColor: uncheckedColor,
          checkBoxColor: uncheckedColor,
          checkColor: Colors.white,
          isDisable: true),
      PersonageCheckBoxLogicState.checkedDisabledCorrectAnswer => PersonageCheckState(
          isChecked: true,
          borderColor: checkedColor,
          checkBoxColor: checkedColor,
          checkColor: Colors.white,
          isDisable: true),
      PersonageCheckBoxLogicState.checkedDisabledWrongAnswer => PersonageCheckState(
          isChecked: true,
          borderColor: Colors.red,
          checkBoxColor: Colors.red,
          checkColor: Colors.white,
          isDisable: true),
      _ => PersonageCheckState(
          isChecked: false, borderColor: uncheckedColor, checkBoxColor: uncheckedColor, checkColor: Colors.white),
    };
  }
}

class ItemState {
  final PersonageCheckBoxLogicState logicState;
  final PersonageCheckState state;
  ItemState({required this.logicState, required this.state});
}

enum PersonageCheckBoxLogicState {
  normal,
  disabledUnchecked(isDisabled: true, showAsDisable: true),
  checked(isChecked: true),
  checkedAndDisabled(isChecked: true, isDisabled: true),
  checkedDisabledCorrectAnswer(isChecked: true, isDisabled: true),
  checkedDisabledWrongAnswer(isChecked: true, isDisabled: true);

  final bool isChecked;
  final bool isDisabled;
  final bool showAsDisable;

  const PersonageCheckBoxLogicState({this.isChecked = false, this.isDisabled = false, this.showAsDisable = false});
}

class PersonageCheckState {
  final bool isChecked;
  final bool isDisable;
  final Color borderColor;
  final Color checkBoxColor;
  final Color checkColor;

  PersonageCheckState(
      {required this.isChecked,
      required this.borderColor,
      required this.checkBoxColor,
      required this.checkColor,
      this.isDisable = false});
}

typedef PickedOptionResult = void Function(int lastIndex, bool isCorrectAnswer);
