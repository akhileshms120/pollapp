import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/splashScreen_cubit.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..loadInitialData(),
      child: const SplashView(),
    );
  }
}

// GetX Controller for animations only
class SplashAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    _setupAnimations();
  }

  void _setupAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    animationController.forward();
  }

  void restartAnimation() {
    animationController.reset();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animController = Get.put(SplashAnimationController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          Get.offNamed(RoutesName.onBoardingScreen);
        } else if (state is SplashError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomWidget.customTextWidget(
                text: 'Error: ${state.message}',
                backgroundColor: AppColor.errorMessage,
              ),
              backgroundColor: AppColor.errorMessage,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomGradientBackground(
          isDarkMode: isDarkMode,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo Container
                CustomAnimatedLogo(
                  size: 150,
                  imagePath: splash_logo,
                  isDarkMode: isDarkMode,
                  fadeAnimation: animController.fadeAnimation,
                  scaleAnimation: animController.scaleAnimation,
                ),
                CustomWidget.verticalSpacer(40),
               
                CustomAnimatedHeader(
                  title: 'Kerala Police',
                  subtitle: 'Pol App',
                  isDarkMode: isDarkMode,
                  fadeAnimation: animController.fadeAnimation,
                  slideAnimation: animController.slideAnimation,
                ),
                CustomWidget.verticalSpacer(60),
                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return CustomLoadingIndicator(
                        message: 'Loading...',
                        isDarkMode: isDarkMode,
                        fadeAnimation: animController.fadeAnimation,
                      );
                    } else if (state is SplashError) {
                      return CustomErrorWidget(
                        onRetry: () {
                          context.read<SplashCubit>().loadInitialData();
                          animController.restartAnimation();
                        },
                        isDarkMode: isDarkMode,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


