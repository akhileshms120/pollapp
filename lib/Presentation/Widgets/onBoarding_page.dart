import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Color bgColor;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      color: bgColor,
      // Add bottom padding to prevent overlap with bottomSheet
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 100, // Space for bottom sheet (80 height + 20 extra)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: isLandscape ? 5 : 4,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              width: size.width * (isLandscape ? 0.5 : 0.8),
            ),
          ),
          SizedBox(height: isLandscape ? 16 : 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                    fontSize: isLandscape ? 24 : 30,
                  ),
            ),
          ),
          SizedBox(height: isLandscape ? 8 : 12),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                        fontSize: isLandscape ? 13 : 16,
                        height: 1.4,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}