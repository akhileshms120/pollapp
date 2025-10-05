import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/bottomNavState.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState(0));

  void selectTab(int index) {
    // Don't select the SOS button (index 2)
    if (index != 2) {
      emit(BottomNavState(index));
    }
  }

  void triggerSOS() {
    // Handle SOS action
    print('SOS Triggered!');
    // Add your emergency logic here
  }
}