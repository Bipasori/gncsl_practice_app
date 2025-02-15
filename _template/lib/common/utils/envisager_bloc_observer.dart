import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class EnvisagerBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('--- Cubit / Bloc is created) ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('--- Cubit / Bloc has a change) ${change.currentState} -> ${change.nextState}');
    log('--- ${change.toString().substring(change.toString().length >= 100 ? 100 : change.toString().length)}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) async {
    super.onError(bloc, error, stackTrace);
    log('--- Cubit / Bloc has an error) ${bloc.runtimeType}, $error, $stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('--- Cubit / Bloc is closed) ${bloc.runtimeType}');
  }
}
