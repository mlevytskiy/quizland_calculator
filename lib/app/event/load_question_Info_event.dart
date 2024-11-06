import 'package:quizland_calculator/app/data/question.dart';
import 'package:quizland_calculator/app/event/any_event_bus_event.dart';

class LoadQuestionInfoEvent extends AnyEventBusEvent {
  final String id;
  final Question question;

  LoadQuestionInfoEvent(this.id, this.question);
}
