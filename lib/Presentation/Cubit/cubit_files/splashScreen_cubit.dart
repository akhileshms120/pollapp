import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '../State/splashScreen_state.dart';


class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> loadInitialData() async {
    emit(SplashLoading());
    
    try {
      // Simulate loading data, API calls, initialization, etc.
      await Future.delayed(const Duration(seconds: 60));
      
      // You can add your initialization logic here:
      // - Check authentication status
      // - Load user preferences
      // - Initialize services
      // - Fetch initial data from API
      
      emit(SplashCompleted());
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
}
