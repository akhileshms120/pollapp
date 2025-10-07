import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Cubit/State/onboardinScreen_state.dart';

import 'package:pollapp/Presentation/Widgets/onBoarding_bottomsheet.dart';
import 'package:pollapp/Presentation/Widgets/onBoarding_page.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      OnboardingPage(
        title: AppConstants.screen1MainTitle,
        description: AppConstants.screen1SubTitle,
        image: onBoardingImage1,
        bgColor: const Color(0xFF81B8DB),
      ),
      OnboardingPage(
        title: AppConstants.screen2MainTitle,
        description: AppConstants.screen2SubTitle,
        image: onBoardingImage2,
        bgColor: const Color(0xFFF7C25E),
      ),
      OnboardingPage(
        title: AppConstants.screen3MainTitle,
        description: AppConstants.screen3SubTitle,
        image: onBoardingImage3,
        bgColor: const Color(0xFFB8EB9E),
      ),
      OnboardingPage(
        title: AppConstants.screen4MainTitle,
        description: AppConstants.screen4SubTitle,
        image: onBoardingImage4,
        bgColor: const Color(0xFF47C3BE),
      ),
      OnboardingPage(
        title: AppConstants.screen3MainTitle,
        description: AppConstants.screen3SubTitle,
        image: onBoardingImage5,
        bgColor: const Color(0xFFEC6D4B),
      ),
    ];

    // Initialize cubit after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingCubit>().initialize(_pages.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state is! OnboardingPageChanged) {
            return const Center(child: CircularProgressIndicator());
          }

          return LiquidSwipe(
            pages: _pages,
            fullTransitionValue: 400,
            enableLoop: false,
            waveType: WaveType.liquidReveal,
            positionSlideIcon: 0.7,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPageChangeCallback: (index) {
              context.read<OnboardingCubit>().updatePage(index, _pages.length);
            },
          );
        },
      ),
      bottomSheet: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state is! OnboardingPageChanged) return const SizedBox.shrink();

          return OnboardingBottomSheet(
            currentPageIndex: state.currentPageIndex,
            totalPages: _pages.length,
            onSkip: () =>
                context.read<OnboardingCubit>().skipToEnd(_pages.length),
            onGetStarted: () => Get.offNamed(RoutesName.loginScreen),
          );
        },
      ),
    );
  }
}
