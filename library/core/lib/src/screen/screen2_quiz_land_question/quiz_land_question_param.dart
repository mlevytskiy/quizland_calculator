import 'package:flutter/widgets.dart';

class QuizLandQuestionParam {
  final String id;
  final String type;
  final ParentScreenInfo parentScreenInfo;
  QuizLandQuestionParam({required this.id, required this.type, required Container container})
      : parentScreenInfo = ParentScreenInfo(container);
}

class ParentScreenInfo {
  final Container container;
  ParentScreenInfo(this.container);
}
