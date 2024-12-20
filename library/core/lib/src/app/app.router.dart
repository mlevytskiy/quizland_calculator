import 'package:core/src/screen/screen3_rewards/rewards_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';
import 'package:repository/repository.dart';

import '../screen/screen0_calculator/calculator_screen.dart';
import '../screen/screen1_quiz_land/quiz_land_screen_bloc_wrapper.dart';
import '../screen/screen2_quiz_land_question/quiz_land_question_param.dart';
import '../screen/screen2_quiz_land_question/quiz_land_question_screen_bloc_wrapper.dart';

// import 'app.locator.dart';

class RouterMediator {
  final UserRepository _userRepository;
  late GoRouter _router;

  RouterMediator(this._userRepository);

  Future<void> init() async {
    bool isHarryPotter = await _userRepository.isHarryPotterQuizlandOpened();
    _router = GoRouter(
      initialLocation: isHarryPotter ? AppPaths.home.quizLand.path : AppPaths.home.path,
      routes: [
        GoRoute(
          path: AppPaths.home.goRoute,
          builder: (context, state) {
            // Di.initAppLocalization(context);
            return const CalculatorScreen();
          },
          routes: [
            GoRoute(
              path: AppPaths.home.quizLand.goRoute,
              pageBuilder: (context, state) =>
                  CustomTransitionPageBuilder(child: const QuizLandScreenBlocWrapper()).build(),
              routes: [
                GoRoute(
                  path: AppPaths.home.quizLand.quizLandQuestion.goRoute,
                  pageBuilder: (context, state) {
                    QuizLandQuestionParam param = state.extra as QuizLandQuestionParam;
                    return CustomTransitionPageBuilder(
                            curve: Curves.slowMiddle,
                            duration: const Duration(milliseconds: 800),
                            child: QuizLandQuestionScreenBlocWrapper(param: param))
                        .build();
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPaths.home.rewards.goRoute,
              builder: (context, state) {
                // Di.initAppLocalization(context);
                return const RewardsScreen();
              },
            ),
          ],
        ),
      ],
    );
  }

  GoRouteInformationProvider getProvider() => _router.routeInformationProvider;

  GoRouteInformationParser getParser() => _router.routeInformationParser;

  GoRouterDelegate getDelegate() => _router.routerDelegate;

  void goHome() {
    _go(AppPaths.home.path);
  }

  void goRewards() {
    _go(AppPaths.home.rewards.path);
  }

  void goQuizLand() {
    _router.replace(AppPaths.home.quizLand.path);
    // _go(AppPaths.home.quizLand.path);
  }

  void goBack(bool result) {
    _router.pop(result);
  }

  void goQuestion(String id, String type, Container container) {
    _go(AppPaths.home.quizLand.quizLandQuestion.path,
        extra: QuizLandQuestionParam(id: id, type: type, container: container));
  }

  Future<bool?> goQuestionForResult(String id, String type, Container container) {
    return _push<bool>(AppPaths.home.quizLand.quizLandQuestion.path,
        extra: QuizLandQuestionParam(id: id, type: type, container: container));
  }

  void _go(String path, {Object? extra}) {
    _router.go(path, extra: extra);
  }

  Future<T?> _push<T extends Object?>(String path, {Object? extra}) async {
    return await _router.push<T>(path, extra: extra);
  }
}

class AppPaths {
  static final HomePath home = HomePath();
}

class HomePath extends Path<HomePath> {
  HomePath() : super('home');
  QuizLand get quizLand => QuizLand(parent: this);
  Rewards get rewards => Rewards(parent: this);
}

class Rewards extends Path<Rewards> {
  Rewards({parent}) : super('rewards', parent: parent);
}

class QuizLand extends Path<QuizLand> {
  QuizLand({parent}) : super('quizland', parent: parent);
  Path get quizLandQuestion => Path('question', parent: this);
}

class CustomTransitionPageBuilder {
  final Duration duration;
  final Widget child;
  final Curve curve;
  CustomTransitionPageBuilder(
      {this.duration = const Duration(seconds: 2), this.curve = Curves.ease, required this.child});

  CustomTransitionPage build() {
    return CustomTransitionPage(
      fullscreenDialog: false,
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      child: child,
      transitionDuration: duration,
    );
  }
}
