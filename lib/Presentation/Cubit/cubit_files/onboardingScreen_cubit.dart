// Part of the library in State/onboardinScreen_state.dart
part of '../State/onboardinScreen_state.dart';



class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingInitial());

  void initialize(int totalPages) {
    emit(OnboardingPageChanged(
      currentPageIndex: 0,
      totalPages: totalPages,
    ));
  }

  void updatePage(int index, int totalPages) {
    emit(OnboardingPageChanged(
      currentPageIndex: index,
      totalPages: totalPages,
    ));
  }

  void skipToEnd(int totalPages) {
    emit(OnboardingPageChanged(
      currentPageIndex: totalPages - 1,
      totalPages: totalPages,
    ));
  }
}