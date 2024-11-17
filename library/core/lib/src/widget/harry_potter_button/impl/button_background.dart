import 'package:core/const/resource.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ButtonBackground extends StatefulWidget {
  final ButtonBackgroundViewTypeEnum viewType;
  final void Function(ButtonBackgroundViewTypeEnum type)? onAnimationEnd;
  const ButtonBackground({super.key, required this.viewType, this.onAnimationEnd});

  @override
  State<ButtonBackground> createState() => _ButtonBackgroundState();
}

class _ButtonBackgroundState extends State<ButtonBackground> {
  final Map<String, dynamic> _circleProperties = {
    'width': 150.0,
    'height': 150.0,
    'borderRadius': 150.0,
    'padding': Di.statusBarHeight,
  };

  final Map<String, dynamic> _pointProperties = {
    'width': 0.0,
    'height': 0.0,
    'padding': 0.0,
  };

  final Map<String, dynamic> _rectangleProperties = {
    'height': 180.0,
    'color': Colors.transparent,
    'borderRadius': 0.0,
    'opacity': 0.5,
    'padding': 0.0,
  };

  V? _get<V>(String property) {
    Map<String, dynamic> map = switch (widget.viewType) {
      ButtonBackgroundViewTypeEnum.point => _pointProperties,
      ButtonBackgroundViewTypeEnum.circle => _circleProperties,
      ButtonBackgroundViewTypeEnum.rectangle => _rectangleProperties,
    };
    try {
      return map[property];
    } catch (e) {
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rectangleProperties['width'] = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: _get('padding')),
      child: AnimatedContainer(
        width: _get('width') ?? 0.0,
        height: _get('height') ?? 0.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_get('borderRadius') ?? 0.0),
          color: _get('color') ?? Colors.green,
          image: DecorationImage(
            image: const AssetImage(R.ASSETS_HOGWARDS_BACKGROUND_PNG, package: "core"),
            opacity: _get('opacity') ?? 0.0,
            fit: BoxFit.fitWidth,
          ),
        ),
        duration: const Duration(seconds: 1),
        onEnd: () => widget.onAnimationEnd?.call(widget.viewType),
      ),
    );
  }
}

typedef BuildWidget = Widget Function(Movie? movie);

class AnimationBuilderWrapper extends StatelessWidget {
  final Widget Function(BuildWidget child) wrapper;
  final BuildWidget child;

  const AnimationBuilderWrapper({super.key, required this.wrapper, required this.child});

  @override
  Widget build(BuildContext context) {
    return wrapper(child);
  }
}

enum ButtonBackgroundViewTypeEnum {
  circle,
  rectangle,
  point,
}
