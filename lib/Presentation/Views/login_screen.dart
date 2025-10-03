import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final verticalSpacing = isLandscape ? 20.0 : 60.0;
    final containerPadding = isLandscape ? 16.0 : 32.0;
    final logoSize = isLandscape ? 60.0 : 80.0;
    final fingerprintSize = isLandscape ? 40.0 : 60.0;

    return Scaffold(
      backgroundColor: AppColor.getBackgroundColor(isDarkMode),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.getBackgroundGradient(isDarkMode),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: isLandscape ? 16.0 : 32.0,
              horizontal: isLandscape ? 32.0 : 0.0,
            ),
            child: Container(
              width: isLandscape
                  ? MediaQuery.of(context).size.width * 0.7
                  : MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(containerPadding),
              decoration: BoxDecoration(
                gradient: AppColor.getContainerGradient(isDarkMode),
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.getShadowColor(isDarkMode),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and Title
                  Column(
                    children: [
                      Image.asset(
                        splash_logo,
                        width: logoSize,
                        height: logoSize,
                      ),
                      SizedBox(height: isLandscape ? 8 : 16),
                      CustomWidget.customTextWidget(
                        text: AppConstants.welcomeText,
                        fontSize: isLandscape ? 24 : 30,
                        fontWeight: FontWeight.w600,
                        textColor: AppColor.getTitleColor(isDarkMode),
                      ),
                      CustomWidget.customTextWidget(
                        text:
                            "Official Mobile app of KERALA POLICE", // typo fixed
                        textColor: AppColor.getSubtitleColor(isDarkMode),
                      ),
                    ],
                  ),
                  SizedBox(height: verticalSpacing),

                  // Phone Number Input
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.getBorderColor(isDarkMode),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColor.getHintColor(isDarkMode),
                        ),
                        hintText: '(+91) 9876543210',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: AppColor.getHintColor(isDarkMode),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.getTextColor(isDarkMode),
                      ),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 20 : 32),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.getButtonColor(isDarkMode),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Get.toNamed(RoutesName.otpScreen);
                      },
                      child: Text(
                        AppConstants.otpButton,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.getButtonTextColor(isDarkMode),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 20 : 40),

                  // Fingerprint Icon with animation
                  GestureDetector(
                    onTap: () {
                      // Handle biometric authentication
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.getIconBackgroundColor(isDarkMode),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.getShadowColor(
                              isDarkMode,
                            ).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fingerprint,
                        size: fingerprintSize,
                        color: AppColor.getIconColor(isDarkMode),
                        semanticLabel: "Login with fingerprint",
                      ),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),

                  // Terms and Privacy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle terms tap
                        },
                        child: Text(
                          "Terms and Conditions", // wording fixed
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.colorMode(
                              mode: isDarkMode,
                              darkModeColor: AppColor.whiteColor,
                              lightModeColor: AppColor.termTextColor,
                            ),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle privacy tap
                        },
                        child: Text(
                          AppConstants.privacyText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.colorMode(
                              mode: isDarkMode,
                              darkModeColor: AppColor.whiteColor,
                              lightModeColor: AppColor.termTextColor,
                            ),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Bottom Indicator
                  Container(
                    width: 80,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColor.getIndicatorColor(isDarkMode),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
