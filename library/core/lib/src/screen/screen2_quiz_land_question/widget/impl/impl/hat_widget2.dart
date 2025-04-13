import 'package:bubble_box/bubble_box.dart';
import 'package:core/const/resource.dart';
import 'package:core/src/app/widget_extension/assets.dart';
import 'package:core/src/app/widget_extension/user_action.dart';
import 'package:core/src/app/widget_extension/visibility.dart';
import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class HatWidget2 extends StatefulWidget {
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

  const HatWidget2(
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
  State<HatWidget2> createState() => _HatWidget2State();
}

class _HatWidget2State extends State<HatWidget2> {
  bool showTextBubble = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                ),
              ).onClick(() => setState(() {
                    showTextBubble = !showTextBubble;
                  })),
              Flexible(
                child: BubbleBox(
                  shape: BubbleShapeBorder(
                    direction: BubbleDirection.left,
                    position: const BubblePosition.end(5),
                    arrowQuadraticBezierLength: 2,
                  ),
                  backgroundColor: const Color(0x7f98E165),
                  margin: const EdgeInsets.only(bottom: 22),
                  child: const Text(
                    '''Hey! I'm sorting hat. Will help you
to pass this exam. What is your name?''',
                  ),
                ),
              ).visible(showTextBubble),
            ],
          ),
          BubbleBox(
            shape: BubbleShapeBorder(
              direction: BubbleDirection.right,
              position: const BubblePosition.end(5),
              arrowQuadraticBezierLength: 2,
            ),
            backgroundColor: const Color(0x7f984960),
            margin: const EdgeInsets.only(left: 70),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("  1) I want to be anonymous"),
                Divider(thickness: 1.0),
                Text("  2) My name is ..."),
              ],
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.only(left: 70),
          //   child: Container(
          //     color: Colors.white24,
          //     width: double.infinity,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text("  1) I want to be anonimous"),
          //         const Divider(thickness: 1.0),
          //         const Text("  2) My name is ..."),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

TextStyle hatMessageTextStyle = const TextStyle(fontSize: 20, color: Colors.white, height: 1.0);
