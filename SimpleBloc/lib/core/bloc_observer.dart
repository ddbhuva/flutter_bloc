import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class MyBlocObserver extends BlocObserver{

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${error}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('${transition}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
      super.onChange(bloc, change);
      debugPrint('${change}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }
}
