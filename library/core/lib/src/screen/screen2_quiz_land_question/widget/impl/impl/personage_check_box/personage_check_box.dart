import 'package:core/src/app/data/impl/pick_multiple_personages.dart';
import 'package:core/src/app/widget_extension/assets.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

import 'personages_check_box_group_controller.dart';

part 'personage_check_box.style.dart';

class PersonageCheckBox extends StatefulWidget {
  final MPOption option;
  final int index;
  final PersonagesCheckBoxGroupController controller;

  const PersonageCheckBox({
    super.key,
    required this.option,
    required this.index,
    required this.controller,
  });

  @override
  State<PersonageCheckBox> createState() => _PersonageCheckBoxState();
}

class _PersonageCheckBoxState extends State<PersonageCheckBox> {
  PersonageCheckState _state() {
    return widget.controller.getUIState(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return ConstraintLayout(
      children: [
        CircleAvatar(
          radius: 37,
          backgroundColor: _state().borderColor,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: widget.option.avatar.imageAsset2(),
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white.withAlpha(100),
              ).visible(_state().isDisable && !_state().isChecked),
            ],
          ),
        ).applyConstraint(
          id: cId("avatar"),
          top: parent.top,
          left: parent.left,
          right: parent.right,
        ),
        widget.option.name.text(style: Style.optionText, textAlign: TextAlign.center).applyConstraint(
              top: cId("avatar").bottom,
              left: parent.left,
              right: parent.right,
            ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return _state().checkBoxColor.withOpacity(.32);
            }
            return _state().checkBoxColor;
          }),
          value: _state().isChecked,
          onChanged: (bool? value) {
            if (_state().isDisable) {
              return;
            }
            setState(() {
              widget.controller.onClick(widget.index);
            });
          },
        ).applyConstraint(
          top: cId("avatar").center,
          bottom: parent.bottom,
          left: cId("avatar").left,
          right: parent.right,
          horizontalBias: 1.0,
          verticalBias: 0.0,
        )
      ],
    ).onClick(() {
      if (_state().isDisable) {
        return;
      }
      setState(() {
        widget.controller.onClick(widget.index);
      });
    });
    // return option.name.text(style: Style.optionText).withImage(option.avatar, circleAvatar: true);
  }
}
