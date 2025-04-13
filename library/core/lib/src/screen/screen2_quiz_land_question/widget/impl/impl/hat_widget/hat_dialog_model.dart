import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/impl/hat_widget/hat_dialog_state_enum.dart';

import 'hat_dialog_action_enum.dart';
import 'hat_dialog_ui_state.dart';

class HatDialogModel {
  final HatDialogUiState uiState;

  HatDialogModel({required this.uiState});

  HatDialogModel.create({required HatDialogStateEnum state, HatDialogActionEnum? lastAction})
      : uiState = _createUIStateFromLogicState(state: state);

  static HatDialogUiState _createUIStateFromLogicState({required HatDialogStateEnum state}) {
    HatDialogUiState uiState = switch (state) {
      HatDialogStateEnum.niceToMeetYou => HatDialogUiState(
            hatMessage: "Hey! I'm sorting hat. Will help you to pass this exam. What is your name?",
            answers: [
              Answer(message: "1) I want to be anonymous", action: HatDialogActionEnum.iWantToBeAnonymous),
              Answer(message: "My name is ...", action: HatDialogActionEnum.enterName),
            ]),
      HatDialogStateEnum.howCanIHelpYou => HatDialogUiState(hatMessage: "How can I help you?", answers: [
          Answer(
              message: "Redo all quiz. I want to pass it again from scratch", action: HatDialogActionEnum.clearAllQuiz),
          Answer(message: "Go back to calculator", action: HatDialogActionEnum.goBackToCalculatorScreen),
          Answer(
              message: "What will be next when I pass hole quiz?",
              action: HatDialogActionEnum.goBackToCalculatorScreen),
        ]),
      HatDialogStateEnum.lastQuestionWithMistake => HatDialogUiState(
            hatMessage: "oh [name], you make mistake in last question.\nDo you want to pass the question again?",
            answers: [
              Answer(message: "yes, please", action: HatDialogActionEnum.clearAllQuiz),
              Answer(message: "NO", action: HatDialogActionEnum.goBackToCalculatorScreen),
            ]),
      HatDialogStateEnum.quizFinished => HatDialogUiState(
            hatMessage: "Congratulation [name]!\nYou pass the exam.\nPlease, collect your rewards!",
            answers: [
              Answer(message: "Super! How can I get my rewards?", action: HatDialogActionEnum.clearAllQuiz),
              Answer(message: "I don't need any rewards", action: HatDialogActionEnum.goBackToCalculatorScreen),
            ]),
      _ => HatDialogUiState(
          hatMessage: "some message", answers: [Answer(message: "my answer", action: HatDialogActionEnum.clearAllQuiz)])
    };
    return uiState;
  }
}
