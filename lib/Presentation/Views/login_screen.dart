import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3341),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF2C3341).withOpacity(0.8),
              const Color(0xFF2C3341).withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and Title
                Column(
                  children: [
                    Image.asset(
                      splash_logo,
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 16),
                     CustomWidget.customTextWidget(text:AppConstants.welcomeText,fontSize: 30,fontWeight: FontWeight.w600,textColor:AppColor.blackColor),
                    CustomWidget.customTextWidget(text:AppConstants.welcomeSubText)
                  ],
                ),
                const SizedBox(height: 60),
                // Phone Number Input
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF6B7A8F),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '(+91)',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 32),
                // Verify Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      
                    },
                    child: Text(
                      AppConstants.otpButton,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C3341),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Fingerprint Icon
                Icon(
                  Icons.fingerprint,
                  size: 60,
                  color: const Color(0xFF6B7A8F),
                ),
                const SizedBox(height: 60),

                // Terms and Privacy
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle terms tap
                      },
                      child: CustomWidget.customTextWidget(text:AppConstants.termsText,fontSize: 16,textColor:AppColor.termTextColor )
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle privacy tap
                      },
                      child: 
                      
                      
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C3341),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Bottom indicator (like iOS home indicator)
                Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
