import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Widget container({Widget? child}) => Container(color: this, child: child);

  Widget circle({Border? border, Widget? child}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border, //Border.all(color: Colors.black, width: 2),
        color: this,
      ),
      child: child,
    );
  }

  Widget circleOrContainer({Border? border, Widget? child, required bool isCircle}) {
    if (isCircle) {
      return circle(border: border, child: child);
    } else {
      return container(child: child);
    }
  }
}
