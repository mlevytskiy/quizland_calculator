import 'package:isar/isar.dart';

import 'Quizland_enum.dart';

part 'Quizland.g.dart';

@embedded
class Quizland {
  @enumerated
  QuizlandEnum quizlandEnum = QuizlandEnum.none;
}
