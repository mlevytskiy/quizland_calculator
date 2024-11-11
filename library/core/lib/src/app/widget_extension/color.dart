import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Widget container({Widget? child}) => Container(color: this, child: child);
}
