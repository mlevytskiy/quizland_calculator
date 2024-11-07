abstract class UserRepository {
  Future<void> openHarryPotterQuizland();
  Future<bool> isHarryPotterQuizlandOpened();
  Future<void> resetAll();

  UserRepositoryCache? getCache();
}

class UserRepositoryCache {
  bool? isHarryPotterQuizlandOpened;
}
