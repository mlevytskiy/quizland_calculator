import 'package:flutter/material.dart';

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

  MaterialColor toMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }
}
