import 'package:core/src/app/app.locator.dart';
import 'package:core/src/widget/screen_container.dart';
import 'package:flutter/material.dart';

import 'widget/calculator_local_hero_wrapper.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      // title: "Calculator state 1",
      child: CalculatorLocalHeroWrapper(
        onPressNext: () async {
          // await Di.userRepository.openHarryPotterQuizland();
          Di.routeMediator.goQuizLand();
        },
      ),

      // Center(
      //   child: TextButton(
      //     onPressed: () async {
      //       await Di.userRepository.openHarryPotterQuizland();
      //       Di.routeMediator.goQuizLand();
      //     },
      //     child: const Text("Next"),
      //   ),
      // ),
    );
  }
}
