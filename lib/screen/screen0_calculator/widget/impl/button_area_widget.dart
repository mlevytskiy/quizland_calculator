import 'package:flutter/widgets.dart';

import 'button_values.dart';

class ButtonAreaWidget extends StatelessWidget {
  final ButtonArea1 area;
  final Widget child;
  const ButtonAreaWidget({super.key, required this.area, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
