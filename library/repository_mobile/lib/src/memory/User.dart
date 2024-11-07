import 'package:isar/isar.dart';

import 'Quizland.dart';

part 'User.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  List<Quizland>? quizlands;
}
