import 'package:flutter/material.dart';
import 'package:pollapp/Presentation/Widgets/serviceIcon_widget.dart';

/// A customizable, compact widget featuring an image with a circular progress border,
/// title, and percentage with enhanced 3D effects and visibility.
class ProgressCircleItem extends StatelessWidget {
  final String title;
  final double progress; // Value between 0.0 and 1.0 (e.g., 0.76 for 76%)
  final Color progressBarColor;
  final GestureTapCallback? onPressed;

  const ProgressCircleItem({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.progress,
    this.progressBarColor = const Color.fromARGB(255, 51, 153, 3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String percentage = '${(progress * 100).toInt()}%';

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Enhanced Stack with better visibility
            Stack(
              alignment: Alignment.center,
              children: [
                // Only show outer glow effect when progress > 0
                if (progress > 0)
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: progressBarColor.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                
                // Only show Enhanced Circular Progress Indicator when progress > 0
                if (progress > 0)
                  SizedBox(
                    width: 74,
                    height: 74,
                    child: CircularProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      strokeWidth: 6, // Increased from 4 to 6 for better visibility
                      backgroundColor: Colors.grey.shade200,
                      color: progressBarColor,
                      strokeCap: StrokeCap.round, // Rounded ends for smoother look
                    ),
                  ),
                
                // 3D Icon Container with enhanced shadows
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      // Bottom shadow for depth
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                      // Top highlight for 3D effect
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade100,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: ServiceIconWidget(serviceId: title),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Enhanced Title Text
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
                letterSpacing: 0.2,
              ),
            ),

            const SizedBox(height: 4),

            // Enhanced Percentage Text with background (only show when progress > 0)
            if (progress > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: progressBarColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: progressBarColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class NavigationCircleItem extends StatelessWidget {
  final String title;
  final GestureTapCallback? onPressed;
  final bool showArrow; // Option to show navigation arrow

  const NavigationCircleItem({
    Key? key,
    required this.onPressed,
    required this.title,
    this.showArrow = true, // Default to showing arrow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stack with 3D Icon Container (no progress bar)
            Stack(
              alignment: Alignment.center,
              children: [
                // 3D Icon Container with enhanced shadows
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      // Bottom shadow for depth
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                      // Top highlight for 3D effect
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade100,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(Icons.arrow_right),
                  ),
                ),
                
                // Optional navigation arrow indicator
              ]
            ),

            const SizedBox(height: 10),

            // Title Text
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}