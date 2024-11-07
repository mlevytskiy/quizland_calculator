import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils.dart';

/// We implemented this class follow this article
/// https://medium.com/nerd-for-tech/flutter-how-to-implement-route-aware-widgets-af8ce7843852
/// article title: Flutter: How to implement route aware widgets
abstract class RouteAwareState<T extends StatefulWidget> extends State<T> with RouteAware {
  RouteObserver<PageRoute>? routeObserver;
  bool enteredScreen = false;

  @override
  void initState() {
    super.initState();
    _addPostFrameCallback((_) {
      _beforeFirstLayout(context);
    });
  }

  void _handler(status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        Timer.run(_enterScreenAfterAnimation);
      }
    }
  }

  // the `initState() completed before getting objects from `context`
  void _beforeFirstLayout(BuildContext context) {
    (ModalRoute.of(context) as PageRoute?)?.let((route) {
      if (mounted) {
        routeObserver = context.read<RouteObserver<PageRoute>?>();
        routeObserver?.subscribe(this, route);
        Timer.run(_enterScreen);
      }
      print("testr route.animation=${route.animation.hashCode}");
      route.animation?.addStatusListener(_handler);
    });
  }

  void _addPostFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback(callback);
  }

  void _enterScreen() {
    _addPostFrameCallback((_) {
      onEnterScreenBeforeAnimation();
      enteredScreen = true;
    });
  }

  void _enterScreenAfterAnimation() {
    print("testr _enterScreenAfterAnimation()");
    onEnterScreenAfterAnimation();
  }

  void _leaveScreen() {
    _addPostFrameCallback((_) {
      if (mounted) {
        onLeaveScreen();
        enteredScreen = false;
      }
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    if (enteredScreen) {
      _leaveScreen();
    }
    routeObserver?.unsubscribe(this);
    // (ModalRoute.of(context) as PageRoute?)?.let((route) {
    //   route.animation?.removeStatusListener(_handler);
    // });
    super.dispose();
  }

  @override
  @mustCallSuper
  void didPopNext() {
    Timer.run(_enterScreen);
  }

  @override
  @mustCallSuper
  void didPop() {
    _leaveScreen();
  }

  @override
  @mustCallSuper
  void didPushNext() {
    _leaveScreen();
  }

  /// this method will always be executed on enter this screen
  void onEnterScreenBeforeAnimation();

  /// this method will always be executed on leaving this screen
  void onLeaveScreen();

  void onEnterScreenAfterAnimation();
}
