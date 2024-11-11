import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

extension ScopeFunctionsForObject<T extends Object> on T {
  ReturnType let<ReturnType>(ReturnType Function(T self) operationFor) {
    return operationFor(this);
  }

  T also(void Function(T self) operationFor) {
    operationFor(this);
    return this;
  }

  ReturnType run<ReturnType>(ReturnType Function() operation) {
    return operation();
  }
}

Future<void> wait({int milliseconds = 0, int seconds = 0}) async =>
    await Future<void>.delayed(Duration(milliseconds: milliseconds, seconds: seconds));

void post(FrameCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback(callback);
}

extension IsVideoEnd on VideoPlayerController {
  bool isVideoEnd() {
    return (!value.isPlaying && value.position > Duration.zero && value.position.inSeconds >= value.duration.inSeconds);
  }
}

extension RX on Random {
  double doubleBetween(double min, double max) {
    return (nextDouble() * (max - min) + min);
  }
}
