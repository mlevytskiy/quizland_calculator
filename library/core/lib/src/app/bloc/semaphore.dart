import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Action<State, T> = void Function(Emitter<State> emit, T? data);

class Semaphore<State, T> {
  final Action<State, T> action;
  T? data;
  VoidCallback? sideEffectCallback;
  int amount = 0;
  Semaphore(this.action);

  void acquire() {
    amount++;
  }

  void release(Emitter<State> emit, {T? data, VoidCallback? sideEffectCallback}) async {
    amount--;
    if (data != null) {
      this.data = data;
      this.sideEffectCallback = sideEffectCallback;
    }
    if (amount == 0) {
      this.sideEffectCallback?.call();
      await wait(milliseconds: 50);
      action(emit, data ?? this.data);
    }
  }
}
