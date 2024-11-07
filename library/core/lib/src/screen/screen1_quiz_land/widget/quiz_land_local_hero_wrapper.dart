import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_hero/local_hero.dart';

import '../bloc/quiz_land_bloc.dart';
import '../bloc/quiz_land_state.dart';
import 'quiz_land_widget.dart';

typedef VoidCallback = void Function();

class QuizLandLocalHeroWrapper extends StatelessWidget {
  const QuizLandLocalHeroWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LocalHeroScope(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubicEmphasized,
      // curve: Curves.bounceInOut,
      child: BlocBuilder<QuizLandBloc, QuizLandState>(
        builder: (context, state) {
          return QuizLandWidget(quizLandState: state);
        },
      ),
    );
  }
}
