import 'package:flutter/material.dart';
import 'package:pollapp/Core/theme/app_theme.dart';
 // Make sure this is imported

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onSearchPressed,
    this.onNotificationPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.darkGrey : AppTheme.primaryBlue;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Logo
              Image.asset(
                'assets/kerala_police_logo.png',
                height: 40,
                width: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.shield,
                    size: 40,
                    color: Colors.white,
                  );
                },
              ),
              const SizedBox(width: 12),

              // Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Icon
              IconButton(
                onPressed: onSearchPressed,
                icon: Icon(Icons.search, color: Colors.white),
                tooltip: 'Search',
              ),

              // Notification Bell
              IconButton(
                onPressed: onNotificationPressed,
                icon: Icon(Icons.notifications, color: Colors.white),
                tooltip: 'Notifications',
              ),
            ],
          ),
        ),
      ),
    );
  }
}