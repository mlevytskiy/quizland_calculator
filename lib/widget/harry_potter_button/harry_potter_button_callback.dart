import 'dart:ui';

typedef LocalHeroAnimationCallback = void Function(String tag);

class HarryPotterButtonCallback {
  final VoidCallback? onTap;
  final VoidCallback? onEndCircleToRectangleTransformation;
  final LocalHeroAnimationCallback? localHeroAnimationCallback;
  const HarryPotterButtonCallback(
      {this.onTap, this.onEndCircleToRectangleTransformation, this.localHeroAnimationCallback});
}
