import 'package:flutter/material.dart';

class OnboardingBottomSheet extends StatelessWidget {
  final int currentPageIndex;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onGetStarted;

  const OnboardingBottomSheet({
    super.key,
    required this.currentPageIndex,
    required this.totalPages,
    required this.onSkip,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Dots Indicator - Always centered using Align
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPageIndex == index ? 10 : 8,
                  height: currentPageIndex == index ? 10 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPageIndex == index
                        ? Colors.indigo
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),

          // Skip Button - Always left aligned
          Align(
            alignment: Alignment.centerLeft,
            child: currentPageIndex != totalPages - 1
                ? TextButton(
                    onPressed: onSkip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Get Started Button - Always right aligned
          Align(
            alignment: Alignment.centerRight,
            child: currentPageIndex == totalPages - 1
                ? ElevatedButton(
                    onPressed: onGetStarted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}