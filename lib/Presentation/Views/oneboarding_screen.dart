// lib/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pollapp/Presentation/Cubit/State/onboardinScreen_state.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart'; // Assuming HomeScreen exists



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

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  // Move the pages list here as a private final field

  Widget _buildPage(BuildContext context, {
    required String title,
    required String description,
    required IconData image,
  }) {
    return Container(
      color: Colors.blue.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            image,
            size: 120,
            color: Colors.blue.shade600,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
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
        title: 'Welcome to Poll App',
        description: 'Discover polls and share your opinion with the community.',
        image: Icons.poll, // Replace with Image.asset if needed
      ),
      _buildPage(context,
        title: 'Create Your Polls',
        description: 'Easily create and manage your own polls.',
        image: Icons.add_chart,
      ),
      _buildPage(context,
        title: 'Join the Conversation',
        description: 'Vote on polls and engage with others.',
        image: Icons.chat_bubble,
      ),
      _buildPage(context,
        title: 'Get Started',
        description: 'Ready to dive in? Let\'s begin!',
        image: Icons.rocket_launch,
      ),
    ];

    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingPageChanged &&
              state.currentPageIndex == state.totalPages - 1) {
            // Optionally auto-navigate or show button
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
                color: Colors.white,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (state.currentPageIndex != pages.length - 1)
                  TextButton(
                    onPressed: () => context.read<OnboardingCubit>().skipToEnd(pages.length),
                    child: const Text('Skip'),
                  )
                else
                  const SizedBox.shrink(),
                // Dots indicator
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
                        MaterialPageRoute(builder: (context) =>  HomeScreen()),
                      );
                    },
                    child: const Text('Get Started'),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}