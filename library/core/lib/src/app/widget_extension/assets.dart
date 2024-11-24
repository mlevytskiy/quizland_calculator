import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

extension AssetsExtension on String {
  // backgroundImage: AssetImage('assets/horse.png'),
  Image imageAsset({double? width, double? height}) {
    String? package = _getPackage();
    return Image.asset(
      this,
      width: width,
      height: height,
      package: package,
    );
  }

  AssetImage imageAsset2() {
    String? package = _getPackage();
    return AssetImage(this, package: package);
  }

  String? _getPackage() {
    String? package;
    if (startsWith("packages")) {
      package = null; //package already added
    } else {
      package = "core";
    }
    return package;
  }
}
