import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final double fontSize;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title = "",
    this.isDarkMode = false,
    this.fontSize = 25,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomWidget.customTextWidget(
        text: title,
        fontSize: fontSize,
        textColor: AppColor.getTextColor(isDarkMode),
      ),
      backgroundColor: isDarkMode
          ? AppColor.darkBackground
          : AppColor.lightBackground,
      elevation: elevation,
      leading: IconButton(
        icon: CustomWidget.iconWidget(
          icon: Icons.arrow_back,
          iconColor: Colors.white,
          isDarkMode: isDarkMode,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Colors.black87;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 130,
      flexibleSpace: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Color(0xFFFFF8F3), // beige base
    Color(0xFFFFEAE2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- Center logo + text ---
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 28),
                Image.asset(
                  'assets/images/logo.png',
                  width: 44,
                  height: 44,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                const Text(
                  "Kerala Police",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 0.3,
                  ),
                ),
                const Text(
                  "Soft in Temperament, Firm in Action",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // --- Top-right icons ---
            Positioned(
              top: 25,
              right: 50,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search_rounded, color: iconColor),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: iconColor,
                        ),
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Bottom divider ---
            const Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                color: Color(0x1F000000),
                height: 0,
                thickness: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
