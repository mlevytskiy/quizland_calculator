import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:repository/repository.dart';
import 'package:repository_mobile/repository_mobile.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Di.locator.addInstance(await UserRepositoryMobile.createIsar());
  Di.locator.addLazySingleton<UserRepository>(UserRepositoryMobile.new);
  await Di.initLocator();
  FlutterNativeSplash.remove();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.quizland_calculator.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isPlatformDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    Di.statusBarHeight = MediaQuery.of(context).padding.top;
    return ThemeProvider(
      initTheme: lightTheme, //isPlatformDark ? darkTheme : lightTheme,
      builder: (context, theme) {
        return MaterialApp.router(
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
