import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';

import '../memory/Quizland.dart';
import '../memory/Quizland_enum.dart';
import '../memory/User.dart';

class UserRepositoryMobile implements UserRepository {
  final Isar isar;
  UserRepositoryCache? _cache;
  UserRepositoryMobile(this.isar);

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

  static Future<UserRepositoryMobile> create() async {
    return UserRepositoryMobile(await createIsar());
  }

  static Future<Isar> createIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );
    return isar;
  }
}
