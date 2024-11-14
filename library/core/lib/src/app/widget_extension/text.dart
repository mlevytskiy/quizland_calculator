import 'package:core/src/app/widget_extension/assets.dart';
import 'package:flutter/material.dart';

extension TextExtension on String {
  Widget text({TextStyle? style, TextAlign? textAlign}) {
    return Text(this, style: style, textAlign: textAlign);
  }
}

extension TextWidgetWxtension on Widget {
  Widget withImage(String? imageFile,
      {bool circleAvatar = true, double? radius = 35, Color? avatarBackground, bool hideText = false}) {
    if (imageFile != null) {
      Widget image = imageFile.imageAsset(width: 120, height: 120);
      if (circleAvatar) {
        image = CircleAvatar(
          radius: radius,
          backgroundColor: avatarBackground,
          backgroundImage: imageFile.imageAsset2(),
        );
      }
      if (hideText) {
        return image;
      }
      return Column(children: [
        const Spacer(),
        image,
        const Spacer(),
        this,
        const Spacer(),
      ]);
    }
    return this;
  }
}
