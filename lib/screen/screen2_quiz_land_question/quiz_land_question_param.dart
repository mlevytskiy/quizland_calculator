import 'package:flutter/widgets.dart';

class QuizLandQuestionParam {
  final String id;
  final String type;
  final ParentScreenInfo parentScreenInfo;
  QuizLandQuestionParam({required this.id, required this.type, required Map<String, Widget> widgetMap})
      : parentScreenInfo = ParentScreenInfo(widgetMap);
}

class ParentScreenInfo {
  final Map<String, Widget> widgetMap;
  ParentScreenInfo(this.widgetMap);
}
