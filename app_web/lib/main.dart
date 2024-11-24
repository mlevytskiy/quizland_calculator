import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:core/core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:repository/repository.dart';
import 'package:repository_web/repository_web.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Di.locator.addLazySingleton<UserRepository>(UserRepositoryWeb.new);
  // Di.locator.addLazySingleton<UserRepository>(()=>UserRepositoryMobile.create());
  await Di.initLocator();
  FlutterNativeSplash.remove();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.quizland_calculator.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(DevicePreview(enabled: true, builder: (context) => const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isPlatformDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    return ThemeProvider(
      initTheme: lightTheme, //isPlatformDark ? darkTheme : lightTheme,
      builder: (context, theme) {
        return MaterialApp.router(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: theme,
          routeInformationProvider: Di.routeMediator.getProvider(),
          routeInformationParser: Di.routeMediator.getParser(),
          routerDelegate: Di.routeMediator.getDelegate(),
          title: 'GoRouter Example',
          // localizationsDelegates: const [
          //   AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('en'), // English
          // ]
        );
      },
    );
  }
}
