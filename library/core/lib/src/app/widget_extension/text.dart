import 'package:flutter/widgets.dart';

extension TextExtension on String {
  Widget text({TextStyle? style}) {
    return Text(this, style: style);
  }
}
