import 'package:bubble_box/bubble_box.dart';
import 'package:collection/collection.dart';
import 'package:core/const/resource.dart';
import 'package:core/src/app/widget_extension/assets.dart';
import 'package:core/src/app/widget_extension/positioning.dart';
import 'package:core/src/app/widget_extension/user_action.dart';
import 'package:core/src/app/widget_extension/visibility.dart';
import 'package:core/src/screen/screen2_quiz_land_question/widget/impl/impl/hat_widget/answer_bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import 'hat_dialog_model.dart';
import 'hat_dialog_ui_state.dart';
import 'hero_info.dart';

class HatWidget3 extends StatefulWidget {
  final HeroInfo heroInfo;
  final HatDialogUiState hatDialogUiState;
  HatWidget3({super.key, required this.heroInfo, required HatDialogModel hatDialogModel})
      : hatDialogUiState = hatDialogModel.uiState;

  @override
  State<HatWidget3> createState() => _HatWidget3State();
}

class _HatWidget3State extends State<HatWidget3> {
  bool showTextBubble = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: WidgetCircularAnimator(
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
                )
                    .localHero(widget.heroInfo.isLocalHeroEnable, widget.heroInfo.localHeroTag)
                    .hero(widget.heroInfo.isHeroEnable, widget.heroInfo.heroHatTag),
              ).onClick(() => setState(() {
                    showTextBubble = !showTextBubble;
                  })),
              Flexible(
                child: BubbleBox(
                  maxWidth: 300,
                  shape: BubbleShapeBorder(
                    direction: BubbleDirection.left,
                    position: const BubblePosition.end(5),
                    arrowQuadraticBezierLength: 2,
                  ),
                  backgroundColor: const Color(0xE03a592c),
                  margin: const EdgeInsets.only(bottom: 22),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.hatDialogUiState.hatMessage,
                        style: const TextStyle(
                            fontSize: 18,
                            height: 1.4,
                            color: Colors.white,
                            decoration: null,
                            fontWeight: FontWeight.normal,
                            fontFamily: "SF Light",
                            package: "core"),
                      )),
                ).visible(showTextBubble, maintainSize: true, maintainAnimation: true, maintainState: true),
              ),
            ],
          ),
          ...widget.hatDialogUiState.answers.mapIndexed((index, answer) {
            bool isLast = index == widget.hatDialogUiState.answers.length - 1;
            return AnswerBubbleBox(message: answer.message, visibility: showTextBubble)
                .padding(EdgeInsets.only(bottom: isLast ? 24 : 8));
          }),
        ],
      ),
    );
  }
}

TextStyle hatMessageTextStyle = const TextStyle(fontSize: 20, color: Colors.white, height: 1.0);
