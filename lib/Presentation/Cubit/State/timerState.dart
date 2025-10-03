class TimerState {
  final int seconds;
  final bool canResend;

  const TimerState({required this.seconds, required this.canResend});

  TimerState copyWith({int? seconds, bool? canResend}) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      canResend: canResend ?? this.canResend,
    );
  }
}
