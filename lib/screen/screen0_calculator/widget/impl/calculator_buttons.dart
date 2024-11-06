import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:local_hero/local_hero.dart';
import 'package:quizland_calculator/widget/harry_potter_button/harry_potter_button.dart';
import 'package:quizland_calculator/widget/harry_potter_button/harry_potter_button_callback.dart';
import 'package:quizland_calculator/widget/harry_potter_button/harry_potter_button_state.dart';
import 'package:quizland_calculator/widget/harry_potter_button/hero_state.dart';

import 'button_area_widget.dart';
import 'button_values.dart';

enum CalculatorButtonsMode {
  usual,
  magic,
}

class CalculatorButtons extends StatefulWidget {
  CalculatorButtonsMode mode;
  List<ButtonAreaWidget> children;
  Map<ButtonArea1, ButtonAreaWidget> childrenMap = {};
  final double? width;
  final double? height;
  final VoidCallback onPressNext;
  CalculatorButtons(
      {super.key, required this.mode, required this.children, this.width, this.height, required this.onPressNext}) {
    for (var child in children) {
      childrenMap[child.area] = child;
    }
  }

  @override
  State<CalculatorButtons> createState() => _CalculatorButtonsState();
}

class _CalculatorButtonsState extends State<CalculatorButtons> {
  bool _isReadyForNavigationNextScreen = false;

  bool isMagicMode() {
    return widget.mode != CalculatorButtonsMode.usual;
  }

  @override
  Widget build(BuildContext context) {
    if (!isMagicMode()) {
      return Wrap(children: widget.children);
    } else {
      return
          // Stack(children: [
          // SizedBox(width: widget.width, height: widget.height),
          // Positioned.fill(child: Container(color: Colors.yellow)),
          ConstraintLayout(
        width: widget.width!,
        height: widget.height!,
        childConstraints: [
          Constraint(
            id: ButtonArea1.calculate.constraintId(),
            bottomRightTo: parent,
            zIndex: 20,
          ),
          Constraint(
            id: ButtonArea1.subtract.constraintId(),
            bottom: ButtonArea1.calculate.constraintId().center,
            left: ButtonArea1.calculate.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.divide.constraintId(),
            right: ButtonArea1.calculate.constraintId().center,
            top: ButtonArea1.calculate.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 18,
          ),
          Constraint(
            id: ButtonArea1.n0.constraintId(),
            right: ButtonArea1.calculate.constraintId().center,
            bottom: ButtonArea1.divide.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.dot.constraintId(),
            bottomCenterTo: parent,
            zIndex: 20,
          ),
          Constraint(
            id: ButtonArea1.n1.constraintId(),
            right: ButtonArea1.dot.constraintId().center,
            top: ButtonArea1.dot.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.n5.constraintId(),
            left: ButtonArea1.n1.constraintId().center,
            top: ButtonArea1.dot.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 21,
          ),
          Constraint(
            id: ButtonArea1.n7.constraintId(),
            left: ButtonArea1.n5.constraintId().center,
            top: ButtonArea1.dot.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 18,
          ),
          Constraint(
            id: ButtonArea1.n2.constraintId(),
            bottomLeftTo: parent,
            zIndex: 20,
          ),
          Constraint(
            id: ButtonArea1.priority.constraintId(),
            right: ButtonArea1.n2.constraintId().center,
            top: ButtonArea1.n2.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.per.constraintId(),
            left: ButtonArea1.n2.constraintId().center,
            top: ButtonArea1.n2.constraintId().top,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.n9.constraintId(),
            right: ButtonArea1.n2.constraintId().center,
            bottom: ButtonArea1.n2.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.clr.constraintId(),
            centerLeftTo: parent,
            zIndex: 20,
          ),
          Constraint(
            id: ButtonArea1.n6.constraintId(),
            right: ButtonArea1.clr.constraintId().center,
            bottom: ButtonArea1.clr.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.n3.constraintId(),
            right: ButtonArea1.clr.constraintId().center,
            top: ButtonArea1.clr.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.n8.constraintId(),
            left: ButtonArea1.n3.constraintId().center,
            top: ButtonArea1.n3.constraintId().top,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.multiply.constraintId(),
            centerRightTo: parent,
            zIndex: 20,
          ),
          Constraint(
            id: ButtonArea1.add.constraintId(),
            left: ButtonArea1.multiply.constraintId().center,
            top: ButtonArea1.multiply.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.n4.constraintId(),
            right: ButtonArea1.add.constraintId().center,
            bottom: ButtonArea1.add.constraintId().bottom,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ButtonArea1.notation.constraintId(),
            left: ButtonArea1.multiply.constraintId().left,
            bottom: ButtonArea1.multiply.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 19,
          ),
          Constraint(
            id: ConstraintId("history"),
            left: ButtonArea1.n3.constraintId().left,
            bottom: ButtonArea1.n3.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 17,
          ),
          Constraint(
            id: ConstraintId("delete"),
            left: ButtonArea1.multiply.constraintId().center,
            bottom: ButtonArea1.multiply.constraintId().center,
            width: wrapContent,
            height: wrapContent,
            zIndex: 17,
          ),
          Constraint(
            id: ConstraintId("r934"),
            bottom: parent.bottom,
            top: parent.top,
            left: parent.left,
            right: parent.right,
            horizontalBias: 0.5,
            verticalBias: 0.0,
            zIndex: 20,
            width: wrapContent,
            height: wrapContent,
          ),
        ],
        children: [
          ButtonArea1.calculate.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.subtract.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.divide.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n0.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.dot.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n1.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n5.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n7.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n2.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.priority.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.per.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n9.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.clr.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n6.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n3.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n8.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.multiply.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.add.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.notation.getWidgetWithConstraintId(widget.childrenMap),
          ButtonArea1.n4.getWidgetWithConstraintId(widget.childrenMap),
          LocalHero(
            tag: "history",
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder()),
                padding: WidgetStateProperty.all(const EdgeInsets.only(left: 5, right: 8, top: 7, bottom: 5)),
                backgroundColor: WidgetStateProperty.all(Colors.white70), // <-- Button color
                foregroundColor: WidgetStateProperty.all(Colors.black),
                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) return Colors.black12; // <-- Splash color
                }),
              ),
              child: const Icon(Icons.history),
            ),
          ).applyConstraintId(id: ConstraintId("history")),
          LocalHero(
            tag: "delete",
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder()),
                padding: WidgetStateProperty.all(const EdgeInsets.only(left: 5, right: 8, top: 7, bottom: 5)),
                backgroundColor: WidgetStateProperty.all(Colors.white70), // <-- Button color
                foregroundColor: WidgetStateProperty.all(Colors.black),
                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) return Colors.black12; // <-- Splash color
                }),
              ),
              child: const Icon(Icons.backspace_outlined),
            ),
          ).applyConstraintId(id: ConstraintId("delete")),
          HarryPotterButton(
            state: HarryPotterButtonState.showOnly934,
            callback: HarryPotterButtonCallback(
              localHeroAnimationCallback: (tag) {
                if (tag == tag9) {
                  widget.onPressNext.call();
                }
              },
              onTap: () {
                widget.onPressNext.call();
              },
            ),
            heroState: HeroState.localHero,
          ).applyConstraintId(id: ConstraintId("r934")),
        ],
      );
      // ]);
    }
  }
}

extension ContrantForButton on ButtonArea1 {
  ConstraintId constraintId() {
    return ConstraintId(text);
  }

  Widget getWidgetWithConstraintId(Map<ButtonArea1, ButtonAreaWidget> childrenMap) {
    return childrenMap[this]!.applyConstraintId(id: constraintId());
  }
}
