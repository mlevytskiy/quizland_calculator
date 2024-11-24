import 'package:repository/repository.dart';

class UserRepositoryWeb implements UserRepository {
  UserRepositoryCache? _cache;
  UserRepositoryWeb();

  @override
  Future<bool> isHarryPotterQuizlandOpened() async {
    return false;
  }

  @override
  Future<void> openHarryPotterQuizland() async {}

  @override
  Future<void> resetAll() async {}

  @override
  UserRepositoryCache? getCache() {
    return _cache;
  }
}
