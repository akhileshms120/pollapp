import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';

import 'package:pollapp/Presentation/Cubit/cubit_files/splashScreen_cubit.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart';
import 'package:pollapp/Presentation/Views/oneboarding_screen.dart';

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

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  OnboardingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        } else if (state is SplashError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [Colors.grey[900]!, Colors.blue.shade900]
                  : [Colors.blue.shade50, Colors.blue.shade800],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (isDarkMode
                                            ? Colors.black
                                            : Colors.black.withOpacity(0.2))
                                        .withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            splash_logo,
                            width: 100,
                            height: 100,
                          ),
                          // Replace with your logo:
                          // child: Image.asset(
                          //   'assets/images/logo.png',
                          //   width: 100,
                          //   height: 100,
                          // ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Kerala Police',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.black87 : Colors.white,

                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Poll App',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode
                                  ? Colors.black54
                                  : Colors.white.withOpacity(0.9),

                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 60),
                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? Colors.black : Colors.blue,
                        ),
                        strokeWidth: 2,
                      );
                    } else if (state is SplashError) {
                      return Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: isDarkMode
                                ? Colors.red.shade300
                                : Colors.red.shade700,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              context.read<SplashCubit>().loadInitialData();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  (isDarkMode ? Colors.grey[800] : Colors.white)
                                      ?.withOpacity(0.2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Retry',
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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
