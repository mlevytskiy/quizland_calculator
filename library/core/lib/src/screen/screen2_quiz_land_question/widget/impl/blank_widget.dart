import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'impl/hat_widget.dart';
import 'impl/hero_data.dart';

class BlankWidget extends StatelessWidget {
  static const Color backgroundColor = Color(0xFF2b2b2b);

  final Color textBackgroundColor;
  final HeroData heroData;
  const BlankWidget({super.key, required this.textBackgroundColor, required this.heroData});

  @override
  Widget build(BuildContext context) {
    return backgroundColor.container(
      child: HatWidget(
              isHeroEnable: heroData.mode.isHeroEnable,
              isLocalHeroEnable: heroData.mode.isLocalHeroEnable,
              heroTextTag: heroData.heroTag2ForText,
              heroHatTag: heroData.heroTag,
              localHeroTag: heroData.localHeroTag,
              textBackgroundOpacity: 0.8,
              textBackgroundColor: textBackgroundColor,
              textBoxWidth: 50,
              textBoxHeight: 50)
          .center(),
    );
  }
}
