import 'package:isar/isar.dart';
import 'package:quizland_calculator/domain/memory/Quizland.dart';
import 'package:quizland_calculator/domain/memory/Quizland_enum.dart';
import 'package:quizland_calculator/domain/memory/User.dart';
import 'package:quizland_calculator/domain/user_repository/user_repository.dart';

class MemoryUserRepository implements UserRepository {
  final Isar isar;
  UserRepositoryCache? _cache;
  MemoryUserRepository(this.isar);

  @override
  Future<bool> isHarryPotterQuizlandOpened() async {
    User? user = await isar.collection<User>().where().findFirst();
    _cache = UserRepositoryCache()..isHarryPotterQuizlandOpened = user?.quizlands?.isNotEmpty ?? false;
    return _cache?.isHarryPotterQuizlandOpened ?? false;
  }

  @override
  Future<void> openHarryPotterQuizland() async {
    User? user = await isar.collection<User>().where().findFirst();
    if (user?.quizlands?.isNotEmpty ?? false) {
      //do nothing
    } else {
      User newUser = User();
      newUser.quizlands = [Quizland()..quizlandEnum = QuizlandEnum.harryPotter];
      await isar.writeTxn(() async {
        await isar.users.put(newUser);
      });
    }
  }

  @override
  Future<void> resetAll() async {
    await isar.writeTxn(() async {
      await isar.users.clear();
    });
  }

  @override
  UserRepositoryCache? getCache() {
    return _cache;
  }
}
