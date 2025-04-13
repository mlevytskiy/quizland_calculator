import 'hat_dialog_action_enum.dart';

class HatDialogUiState {
  final String hatMessage;
  final List<Answer> answers;
  HatDialogUiState({required this.hatMessage, required this.answers});
}

class Answer {
  final String message;
  final HatDialogActionEnum action;
  Answer({required this.message, required this.action});
}
