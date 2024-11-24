import 'package:flutter/widgets.dart';

extension UserAction on Widget {
  Widget onClick(VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: this,
    );
  }
}
