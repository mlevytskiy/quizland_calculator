import 'package:core/src/app/app.locator.dart';
import 'package:core/src/app/route_aware_state.dart';
import 'package:core/src/widget/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_land_bloc.dart';
import 'bloc/quiz_land_event.dart';
import 'widget/quiz_land_local_hero_wrapper.dart';

class QuizLandScreen extends StatefulWidget {
  const QuizLandScreen({super.key});

  @override
  State<QuizLandScreen> createState() => _QuizLandScreenState();
}

class _QuizLandScreenState extends RouteAwareState<QuizLandScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(child: QuizLandLocalHeroWrapper());
  }

  @override
  void onEnterScreenAfterAnimation() {
    QuizLandBloc bloc = context.read<QuizLandBloc>();
    bloc.add(OpenScreenFirstTime());
  }

  @override
  void onEnterScreenBeforeAnimation() {
    if (!Di.audioPlayer.playing) {
      Di.audioPlayer.play();
    }
  }

  @override
  void onLeaveScreen() {
    if (Di.audioPlayer.playing) {
      Di.audioPlayer.stop();
    }
  }
}
