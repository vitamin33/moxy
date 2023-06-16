import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CubitWithEffects<State, Effect> extends Cubit<State> {
  final _effectController = StreamController<Effect>.broadcast();

  CubitWithEffects(super.initialState);

  Stream<Effect> get effectStream => _effectController.stream;

  void emitEffect(Effect effect) {
    _effectController.sink.add(effect);
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
