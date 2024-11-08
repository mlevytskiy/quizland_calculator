import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:core/const/resource.dart';
import 'package:core/src/app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:local_hero/local_hero.dart';
import 'package:typethis/typethis.dart';

import 'harry_potter_button_callback.dart';
import 'harry_potter_button_state.dart';
import 'hero_state.dart';
import 'impl/button_background.dart';

const String tag9 = "r9";
const String tagYellowCircle = "r934_yellow_circle";
const String tagHero = "hero";
const String tagHogwards = "hogwards";
const String tag3 = "r3";
const String tag4 = "r4";
const String tagLine = "line";
const String tag9background = "r934_background";
const String tagLightning = "r934_lightning";
const String tagEyesGlasses = "r934_eyes_glasses";

class HarryPotterButton extends StatefulWidget {
  HeroState heroState;
  late HarryPotterButtonCallback callback;
  HarryPotterButtonState state;

  HarryPotterButton({
    super.key,
    required this.state,
    required this.heroState,
    HarryPotterButtonCallback? callback,
  }) {
    this.callback = callback ?? const HarryPotterButtonCallback();
  }

  @override
  State<HarryPotterButton> createState() => _HarryPotterButtonState();
}

class _HarryPotterButtonState extends State<HarryPotterButton> {
  final ValueNotifier<AfterEffect>? createCircleButtonAfterEffect = ValueNotifier(AfterEffect.none);

  @override
  void initState() {
    super.initState();
    createCircleButtonAfterEffect?.addListener(() async {
      if (createCircleButtonAfterEffect?.value == AfterEffect.start &&
          widget.state == HarryPotterButtonState.showOnly934) {
        setState(() {
          widget.state = HarryPotterButtonState.circleButton;
        });
        await wait(milliseconds: 1600);
        setState(() {
          widget.heroState = HeroState.betweenScreens;
        });
        await wait(milliseconds: 20);
        createCircleButtonAfterEffect?.value == AfterEffect.finish;
      }
    });
  }

  @override
  void dispose() {
    createCircleButtonAfterEffect?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetWrapper(
      wrapper: (child) => widget.heroState.isHeroEnable ? Hero(tag: tagHero, child: child) : child,
      child: ConstraintLayout(
        width: wrapContent,
        height: wrapContent,
        childConstraints: [
          Constraint(
            id: cId(tagYellowCircle),
            bottom: parent.bottom,
            top: parent.top,
            left: parent.left,
            right: parent.right,
            verticalBias: widget.state.showHeaderTextMessage ? 0.1 : 0.5,
            zIndex: 11,
          ),
          if (widget.state.showHeaderTextMessage)
            Constraint(
              id: cId(tagHogwards),
              bottom: parent.bottom,
              top: parent.top,
              left: parent.left,
              right: parent.right,
              verticalBias: 0.9,
              zIndex: 11,
            ),
          if (widget.state.showExam)
            Constraint(
              id: cId("cross"),
              bottom: cId(tagHogwards).bottom,
              top: cId(tagHogwards).top,
              left: cId(tagHogwards).center,
              right: cId(tagHogwards).right,
              verticalBias: 0.0,
              zIndex: 12,
            ),
          if (widget.state.showExam)
            Constraint(
              id: cId("exam"),
              bottom: cId("cross").top,
              top: parent.top,
              left: cId(tagHogwards).center,
              right: parent.right,
              verticalBias: 0.9,
              zIndex: 12,
            ),
          Constraint(
            id: cId(tag9),
            right: parent.center,
            bottom: cId(tagYellowCircle).bottom,
            top: cId(tagYellowCircle).top,
            zIndex: 20,
          ),
          Constraint(
            id: cId(tag3),
            left: cId(tag9).right,
            bottom: cId(tag9).center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 17,
          ),
          Constraint(
            id: cId(tag4),
            left: cId(tag9).right,
            top: cId(tag9).center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 17,
          ),
          Constraint(
            id: cId(tagLine),
            left: cId(tag9).right,
            top: cId(tag3).bottom,
            bottom: cId(tag4).top,
            width: wrapContent,
            height: wrapContent,
            zIndex: 17,
          ),
          Constraint(
            id: cId(tag9background),
            bottom: parent.bottom,
            top: parent.top,
            left: parent.left,
            right: parent.right,
            zIndex: 10,
          ),
          if (widget.state.hideImagesLightingAndEyesGlasses)
            Constraint(
              id: cId(tagLightning),
              top: parent.top,
              left: parent.left,
              zIndex: 21,
            ),
          if (!widget.state.hideImagesLightingAndEyesGlasses)
            Constraint(
              id: cId(tagLightning),
              bottom: cId(tag9).center,
              right: cId(tag9).center,
              zIndex: 21,
            ),
          Constraint(
            id: cId(tagEyesGlasses),
            bottom: cId(tag3).center,
            left: cId(tag9).center,
            pinnedInfo: PinnedInfo(
              cId(tag3),
              Anchor(0.3, AnchorType.percent, 0.9, AnchorType.percent),
              Anchor(0, AnchorType.percent, 0, AnchorType.percent),
              angle: 60,
            ),
            zIndex: 21,
          ),
        ],
        children: [
          LocalHeroWidgetWrapper(widget,
              tag: tagYellowCircle,
              child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: widget.state.showYellowCircle ? 70.0 : 0.0,
                  height: widget.state.showYellowCircle ? 70.0 : 0.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.amber,
                  ))).applyConstraintId(id: cId(tagYellowCircle)),
          LocalHeroWidgetWrapper(widget,
              tag: tag9,
              afterEffect: (widget.state == HarryPotterButtonState.showOnly934) ? createCircleButtonAfterEffect : null,
              child: const DefaultTextStyle(
                style: TextStyle(
                  fontSize: 50,
                  height: 0.9,
                  color: Colors.black,
                  decoration: null,
                  fontWeight: FontWeight.normal,
                ),
                child: Text(
                  "9",
                ),
              )).applyConstraintId(id: cId(tag9)),
          LocalHeroWidgetWrapper(widget,
              tag: tag3,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 25,
                    height: 0.9,
                    color: Colors.black,
                    decoration: null,
                    fontWeight: FontWeight.normal,
                  ),
                  child: Text(
                    "3",
                  ),
                ),
              )).applyConstraintId(id: cId(tag3)),
          LocalHeroWidgetWrapper(widget,
              tag: tag4,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 25,
                    height: 0.9,
                    color: Colors.black,
                    decoration: null,
                    fontWeight: FontWeight.normal,
                  ),
                  child: Text(
                    "4",
                  ),
                ),
              )).applyConstraintId(id: cId(tag4)),
          LocalHeroWidgetWrapper(widget, tag: tagLine, child: Container(color: Colors.black, width: 15, height: 2))
              .applyConstraintId(id: cId(tagLine)),
          GestureDetector(
              onTap: widget.callback.onTap,
              child: ButtonBackground(
                viewType: widget.state.buttonBackgroundViewTypeEnum,
                onAnimationEnd: (type) {
                  if (type == ButtonBackgroundViewTypeEnum.rectangle) {
                    widget.callback.onEndCircleToRectangleTransformation?.call();
                  }
                },
              )).applyConstraintId(id: cId(tag9background)),
          LocalHeroWidgetWrapper(widget,
                  tag: tagLightning,
                  child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.bounceIn,
                      width: widget.state.lightningWidth,
                      height: widget.state.lightningHeight,
                      child: const Image(image: AssetImage(R.ASSETS_LIGHTNING_PNG, package: "core"))))
              .applyConstraintId(id: cId(tagLightning)),
          AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.bounceIn,
                  width: widget.state.eyesGlassesWidth,
                  height: widget.state.eyesGlassesHeight,
                  child: const Image(image: AssetImage(R.ASSETS_EYESGLASSES_PNG, package: "core")))
              .applyConstraintId(id: cId(tagEyesGlasses)),
          if (widget.state.showHeaderTextMessage)
            const SizedBox(
                width: 255,
                child: TypeThis(
                  string: "Hogwards express",
                  speed: 150,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 35,
                      height: 0.9,
                      color: Colors.amber,
                      decoration: null,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Harry",
                      package: "core"),
                )).applyConstraintId(id: cId(tagHogwards)),
          if (widget.state.showExam)
            Container(child: const Image(image: AssetImage(R.ASSETS_CROSS_PNG, package: "core")))
                .applyConstraintId(id: cId("cross")),
          if (widget.state.showExam)
            Container(child: const Image(image: AssetImage(R.ASSETS_EXAM_PNG, package: "core")))
                .applyConstraintId(id: cId("exam")),
        ],
      ),
    );
  }
}

class LocalHeroWidgetWrapper extends StatelessWidget {
  final String tag;
  final Widget child;
  final HarryPotterButton parent;
  final ValueNotifier<AfterEffect>? afterEffect;

  const LocalHeroWidgetWrapper(this.parent, {super.key, required this.tag, required this.child, this.afterEffect});

  @override
  Widget build(BuildContext context) {
    return WidgetWrapper(
      wrapper: (Widget child) => parent.heroState.isLocalHeroEnable
          ? LocalHero(
              tag: tag,
              onAnimationEnd: () async {
                if (afterEffect != null) {
                  afterEffect?.value = AfterEffect.start;
                  await wait(milliseconds: 1650);
                  parent.callback.localHeroAnimationCallback?.call(tag);
                } else {
                  parent.callback.localHeroAnimationCallback?.call(tag);
                }
              },
              child: child,
            )
          : child,
      child: child,
    );
  }
}

enum AfterEffect {
  none,
  start,
  finish;
}
