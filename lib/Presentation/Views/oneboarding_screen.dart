// lib/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Presentation/Cubit/State/onboardinScreen_state.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart';
import 'package:pollapp/Presentation/Widgets/custom_onBoarding.dart'; // Assuming HomeScreen exists



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const OnboardingView(),
    );
  }
}

