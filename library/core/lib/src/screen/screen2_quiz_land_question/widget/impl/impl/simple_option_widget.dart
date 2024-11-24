import 'dart:async';

import 'package:core/core.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:core/src/screen/screen2_quiz_land_question/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';

enum SimpleCircleOptionState {
  clickable,
  selectedCorrectAnswer(isSelected: true),
  selectedWrongAnswer(isSelected: true),
  disabled;

  final bool isSelected;
  const SimpleCircleOptionState({this.isSelected = false});
}

class SimpleOptionWidget extends StatefulWidget {
  final Color color;
  final Color selectedColor;
  final Color disabledColor;
  final Color correctAnswerColor;
  final Color wrongAnswerColor;
  final String text;
  final TextStyle style;
  final VoidCallback onClick;
  final SimpleCircleOptionState state;
  final bool isCircle;
  final String? imageFile;
  final bool useOnlyImageWithoutText;

  const SimpleOptionWidget({
    super.key,
    required this.color,
    required this.selectedColor,
    required this.disabledColor,
    required this.text,
    required this.style,
    required this.onClick,
    this.state = SimpleCircleOptionState.clickable,
    this.correctAnswerColor = Colors.green,
    this.wrongAnswerColor = Colors.red,
    this.useOnlyImageWithoutText = false,
    required this.isCircle,
    this.imageFile,
  });

  @override
  State<SimpleOptionWidget> createState() => _SimpleOptionWidgetState();
}

class _SimpleOptionWidgetState extends State<SimpleOptionWidget> {
  Timer? _timer;
  late Color background;
  bool _stopChangeBackground = false;

  @override
  Widget build(BuildContext context) {
    bool hideText = widget.useOnlyImageWithoutText;
    bool circleAvatar = !widget.useOnlyImageWithoutText;
    return background
        .circleOrContainer(
            child: Text(
              widget.text,
              style: widget.style,
              textAlign: TextAlign.center,
            )
                .withImage(
                  widget.imageFile,
                  circleAvatar: circleAvatar,
                  avatarBackground: background.withAlpha(100),
                  hideText: hideText,
                )
                .center(),
            isCircle: widget.isCircle)
        .onClick(() {
      if (SimpleCircleOptionState.clickable == widget.state) {
        widget.onClick();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    if (_stopChangeBackground) {
      return;
    }
    background = switch (widget.state) {
      SimpleCircleOptionState.clickable => widget.color,
      SimpleCircleOptionState.disabled => widget.disabledColor,
      _ => widget.selectedColor,
    };
  }

  @override
  void didUpdateWidget(SimpleOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_stopChangeBackground) {
      return;
    }
    background = switch (widget.state) {
      SimpleCircleOptionState.clickable => widget.color,
      SimpleCircleOptionState.disabled => widget.disabledColor,
      _ => widget.selectedColor,
    };
    if (widget.state.isSelected) {
      _timer = Timer(const Duration(seconds: 1), () async {
        _stopChangeBackground = true;
        if (mounted) {
          bool isCorrect = widget.state == SimpleCircleOptionState.selectedCorrectAnswer;
          setState(() {
            if (isCorrect) {
              background = widget.correctAnswerColor;
            } else {
              background = widget.wrongAnswerColor;
            }
          });
          await wait(milliseconds: 700);
          _bloc().emitSideEffect(CloseScreenSideEffect(isCorrect));
        }
      });
    }
  }

  QuizLandQuestionBloc _bloc() => context.read<QuizLandQuestionBloc>();
}
