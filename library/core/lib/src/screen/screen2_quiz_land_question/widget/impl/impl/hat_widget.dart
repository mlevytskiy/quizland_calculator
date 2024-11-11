import 'package:core/const/resource.dart';
import 'package:core/src/app/widget_extension/assets.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

part 'hat_widget.style.dart';

class HatWidget extends StatelessWidget {
  final bool isHeroEnable;
  final bool isLocalHeroEnable;
  final String heroTextTag;
  final String heroHatTag;
  final String localHeroTag;
  final Color textBackgroundColor;
  final double textBackgroundOpacity;
  final String? message;
  final double textBoxWidth;
  final double textBoxHeight;

  const HatWidget(
      {super.key,
      required this.isHeroEnable,
      required this.isLocalHeroEnable,
      required this.heroTextTag,
      required this.heroHatTag,
      required this.localHeroTag,
      required this.textBackgroundColor,
      required this.textBackgroundOpacity,
      this.message,
      required this.textBoxWidth,
      required this.textBoxHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        textBackgroundColor
            .container()
            .animatedOpacity(textBackgroundOpacity)
            .size(textBoxWidth, textBoxHeight)
            .padding(const EdgeInsets.only(left: 25.0, bottom: 50.0))
            .hero(isHeroEnable, heroTextTag)
            .localHero(isLocalHeroEnable, heroTextTag),
        (message ?? "")
            .text(style: hatMessageTextStyle)
            .localHero(isLocalHeroEnable, "hat_text")
            .center()
            .padding(const EdgeInsets.only(left: 40.0, bottom: 50.0))
            .fillPosition(),
        Row(
          children: [
            WidgetCircularAnimator(
              size: 50,
              innerIconsSize: 3,
              outerIconsSize: 3,
              innerAnimation: Curves.easeInOutBack,
              outerAnimation: Curves.easeInOutBack,
              innerColor: Colors.deepPurple,
              outerColor: Colors.blue.shade700,
              innerAnimationSeconds: 10,
              outerAnimationSeconds: 10,
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                child: R.ASSETS_HARRY_POTTER_HAT_PNG.imageAsset(),
              ),
            ).localHero(isLocalHeroEnable, localHeroTag).hero(isHeroEnable, heroHatTag),
            const Spacer(),
          ],
        ).fillPosition(),
      ],
    );
  }
}
