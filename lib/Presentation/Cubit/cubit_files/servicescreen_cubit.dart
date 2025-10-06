

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/servicestate.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(const ServicesState());

  void pressCard(int index) {
    emit(state.copyWith(pressedCardIndex: index));
  }

  void releaseCard() {
    emit(const ServicesState(pressedCardIndex: null));
  }
}