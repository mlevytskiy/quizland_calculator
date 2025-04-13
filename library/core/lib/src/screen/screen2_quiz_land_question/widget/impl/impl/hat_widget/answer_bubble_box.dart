import 'package:bubble_box/bubble_box.dart';
import 'package:core/src/app/widget_extension/widget_extensions.dart';
import 'package:flutter/material.dart';

class AnswerBubbleBox extends StatelessWidget {
  final String message;
  final bool visibility;

  const AnswerBubbleBox({super.key, required this.message, required this.visibility});

  @override
  Widget build(BuildContext context) {
    return BubbleBox(
      shape: BubbleShapeBorder(
        direction: BubbleDirection.none,
        position: const BubblePosition.end(5),
        arrowQuadraticBezierLength: 2,
      ),
      backgroundColor: const Color(0xE0103e89), //02453a3),
      margin: const EdgeInsets.only(left: 70),
      child: SizedBox(
        width: 200,
        child: Text(message,
            style: const TextStyle(
                fontSize: 18,
                height: 1.4,
                color: Colors.white,
                decoration: null,
                fontWeight: FontWeight.w300,
                fontFamily: "SF Light",
                package: "core")),
      ),
    ).visible(visibility, maintainSize: true, maintainAnimation: true, maintainState: true);
  }
}
