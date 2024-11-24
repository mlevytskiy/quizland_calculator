import 'package:flutter/widgets.dart';
import 'package:local_hero/local_hero.dart';

import 'impl/calculator_widget.dart';

typedef VoidCallback = void Function();

class CalculatorLocalHeroWrapper extends StatelessWidget {
  final VoidCallback onPressNext;

  const CalculatorLocalHeroWrapper({super.key, required this.onPressNext});

  @override
  Widget build(BuildContext context) {
    return LocalHeroScope(
        duration: const Duration(seconds: 2),
        // curve: Curves.easeInOutCubicEmphasized,
        curve: Curves.bounceInOut,
        child: CalculatorWidget(onPressNext: onPressNext));
  }
}
