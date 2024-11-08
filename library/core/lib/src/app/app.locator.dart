import 'package:auto_injector/auto_injector.dart';
import 'package:core/const/resource.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:repository/repository.dart';

import 'app.router.dart';
import 'long_running_isolate.dart';
// late AppLocalizations s;

class Di {
  static final AutoInjector locator = AutoInjector();

  static RouterMediator get routeMediator => locator.get<RouterMediator>();
  static UserRepository get userRepository => locator.get<UserRepository>();
  static YAJsonIsolate get readAssetsIsolate => locator.get<YAJsonIsolate>();
  static AudioPlayer get audioPlayer => locator.get<AudioPlayer>();

  static Future<void> initLocator() async {
    // locator.addLazySingleton<UserRepository>(MemoryUserRepository.new);
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

  static Future<void> audioPlayerInit() async {
    ClippingAudioSource playList = ClippingAudioSource(
      start: const Duration(seconds: 0),
      end: const Duration(seconds: 35, milliseconds: 500),
      child: AudioSource.asset(R.ASSETS_HARRY_POTTER_BACKGROUND_MUSIC_MP3, package: "core"),
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
