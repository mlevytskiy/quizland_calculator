import 'package:auto_injector/auto_injector.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:forestclone/domain/data/memory/task.dart';
// import 'package:forestclone/domain/repository_task/impl/memory_task_repository.dart';
// import 'package:forestclone/domain/repository_task/task_repository.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizland_calculator/app/app.router.dart';
import 'package:quizland_calculator/app/long_running_isolate.dart';
import 'package:quizland_calculator/domain/memory/User.dart';
import 'package:quizland_calculator/domain/user_repository/impl/memory_user_repository.dart';
import 'package:quizland_calculator/domain/user_repository/user_repository.dart';
import 'package:typed_event_bus/typed_event_bus.dart';
// late AppLocalizations s;

class Di {
  static final AutoInjector locator = AutoInjector();
  static final bus = locator.get<TypedEventBus>();

  static RouterMediator get routeMediator => locator.get<RouterMediator>();
  static UserRepository get userRepository => locator.get<UserRepository>();
  static YAJsonIsolate get readAssetsIsolate => locator.get<YAJsonIsolate>();
  static AudioPlayer get audioPlayer => locator.get<AudioPlayer>();

  static Future<void> initLocator() async {
    locator.addInstance(await _createIsar());
    locator.addLazySingleton<UserRepository>(MemoryUserRepository.new);
    locator.addLazySingleton<TypedEventBus>(TypedEventBus.new);
    locator.addLazySingleton<RouterMediator>(RouterMediator.new);
    locator.addLazySingleton<YAJsonIsolate>(YAJsonIsolate.new);
    locator.addLazySingleton<AudioPlayer>(AudioPlayer.new);
    // locator.addInstance<BuildContext?>(null); //will be replaced later
    // locator.addLazySingleton<AppLocalizations>(
    //   () => AppLocalizations.of(locator.get<BuildContext?>()!),
    // );
    locator.commit();
    await routeMediator.init();
    await readAssetsIsolate.initialize();
    await audioPlayerInit();
  }

  static Future<Isar> _createIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );
    return isar;
  }

  static Future<void> audioPlayerInit() async {
    ClippingAudioSource playList = ClippingAudioSource(
      start: const Duration(seconds: 0),
      end: const Duration(seconds: 35, milliseconds: 500),
      child: AudioSource.asset("assets/harry_potter/background_music.mp3"),
      tag: const MediaItem(
        id: '10',
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science (30 seconds)",
        // artUri: Uri.parse(
        //     "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    );
    await audioPlayer.setAudioSource(playList);
    await audioPlayer.setLoopMode(LoopMode.one);
  }

  // static void initAppLocalization(BuildContext context) {
  //   locator.replaceInstance<BuildContext?>(context);
  //   s = locator.get<AppLocalizations>();
  // }
}
