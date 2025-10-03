import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/timerState.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState(seconds: 30, canResend: false));

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    emit(const TimerState(seconds: 30, canResend: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.seconds == 0) {
        timer.cancel();
        emit(state.copyWith(canResend: true));
      } else {
        emit(state.copyWith(seconds: state.seconds - 1));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}