
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Presentation/Cubit/State/onboardinScreen_state.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  // Move the pages list here as a private final field
Widget _buildPage(BuildContext context, {
  required String title,
  required String description,
  required String image,
  required int bgColor,
}) {
  return Container(
    color: Color(bgColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
            fontSize: 33,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildPage(context,
        title: AppConstants.screen1MainTitle,
        description: AppConstants.screen1SubTitle,
        image: onBoardingImage1,
        bgColor: 0xFF81B8DB// ligt blue color
      ),
      _buildPage(context,
        title: AppConstants.screen2MainTitle,
        description: AppConstants.screen2SubTitle,
        image: onBoardingImage2,
        bgColor: 0xFFf7c25e
      ),
      _buildPage(context,
        title: AppConstants.screen3MainTitle,
        description: AppConstants.screen3SubTitle,
        image: onBoardingImage3,
        bgColor: 0xFFb8eb9e,
      ),
      _buildPage(context,
        title: AppConstants.screen4MainTitle,
        description: AppConstants.screen4SubTitle,
        image: onBoardingImage4,
        bgColor: 0xFF47c3be
      ),  _buildPage(context,
        title: AppConstants.screen3MainTitle,
        description: AppConstants.screen3SubTitle,
        image: onBoardingImage5,
        bgColor: 0xFFec6d4b,
      ),
     
    ];

    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingPageChanged &&
              state.currentPageIndex == state.totalPages - 1) {
          }
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final cubit = context.read<OnboardingCubit>();
            if (state is! OnboardingPageChanged) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                cubit.initialize(pages.length);
              });
              return Center(child: CircularProgressIndicator());
            }

            return LiquidSwipe(
              pages: pages,
              fullTransitionValue: 180,
              onPageChangeCallback: (index) {
                cubit.updatePage(index, pages.length);
              },
              positionSlideIcon: 0.7,
              slideIconWidget: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 30,
              ),
              waveType: WaveType.liquidReveal,
              enableLoop: false,
            );
          },
        ),
      ),
   bottomSheet: BlocBuilder<OnboardingCubit, OnboardingState>(
  builder: (context, state) {
    if (state is! OnboardingPageChanged) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (state.currentPageIndex != pages.length - 1)
              TextButton(
                onPressed: () => context.read<OnboardingCubit>().skipToEnd(pages.length),
                child: const Text('Skip'),
              )
            else
              const SizedBox.shrink(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.currentPageIndex == index
                        ? Colors.indigo
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            if (state.currentPageIndex == pages.length - 1)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const Text('Get Started'),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  },
),);
  }
}