import 'package:flutter/widgets.dart';

extension VisibilityExtension on Widget {
  /// Wraps this widget with a [Visibility] widget.
  Widget visible(
    bool visible, {
    Widget replacement = const SizedBox.shrink(),
    bool maintainState = false,
    bool maintainAnimation = false,
    bool maintainSize = false,
    bool maintainSemantics = false,
    bool maintainInteractivity = false,
  }) =>
      Visibility(
        visible: visible,
        replacement: replacement,
        maintainState: maintainState,
        maintainAnimation: maintainAnimation,
        maintainSize: maintainSize,
        maintainSemantics: maintainSemantics,
        maintainInteractivity: maintainInteractivity,
        child: this,
      );

  /// Wraps this widget with an [Offstage] widget.
  Widget offstage(bool offstage) => Offstage(
        offstage: offstage,
        child: this,
      );

  Widget animatedOpacity(double opacity,
      {Duration duration = const Duration(milliseconds: 500), Curve curve = Curves.ease}) {
    return AnimatedOpacity(
      duration: duration,
      curve: curve,
      opacity: opacity,
      child: this,
    );
  }
}
