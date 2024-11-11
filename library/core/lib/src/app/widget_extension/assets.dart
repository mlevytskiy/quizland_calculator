import 'package:flutter/widgets.dart';

extension AssetsExtension on String {
  Widget imageAsset() {
    return Image.asset(
      this,
      package: "core",
    );
  }
}
