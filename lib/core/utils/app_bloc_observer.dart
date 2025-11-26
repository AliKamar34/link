import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('$change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('$transition');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('closed $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('create $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('error in $bloc \n the error is $error ');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('event in $bloc \n event : $event');
  }

  @override
  void onDone(
    Bloc bloc,
    Object? event, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    debugPrint('done $bloc ');
  }
}
