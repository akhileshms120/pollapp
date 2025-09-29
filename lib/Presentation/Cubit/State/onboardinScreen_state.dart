import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../cubit_files/onboardingScreen_cubit.dart';



abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();

  @override
  List<Object> get props => [];
}

class OnboardingPageChanged extends OnboardingState {
  final int currentPageIndex;
  final int totalPages;

  const OnboardingPageChanged({
    required this.currentPageIndex,
    required this.totalPages,
  });

  @override
  List<Object> get props => [currentPageIndex, totalPages];
}