import 'package:flutter/widgets.dart';

extension AssetsExtension on String {
  Widget imageAsset() {
    String? package;
    if (startsWith("packages")) {
      package = null; //package already added
    } else {
      package = "core";
    }
    return Image.asset(
      this,
      package: package,
    );
  }
}
