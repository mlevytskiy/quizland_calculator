import 'package:flutter_bloc_side_effect/flutter_bloc_side_effect.dart';

class SideEffectBloc<E, S, SE> extends Bloc<E, S> with BlocSideEffectMixin<E, S, SE> {
  SideEffectBloc(super.initialState);
}
