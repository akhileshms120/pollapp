import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';
import 'package:pollapp/logs/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';


class TermsandcontdionScreen extends StatelessWidget {
  const TermsandcontdionScreen({super.key});


void _lauchEmail() async {
  const String email = 'mobileapp.pol@kerala.gov.in';
  
  try {
    final Uri emailLaunchUri = Uri(
      scheme: "mailto",
      path: email,
    );
    
    await launchUrl(
      emailLaunchUri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    LogService.error('Could not launch email client. $e');
    
    // Copy to clipboard
    await Clipboard.setData(const ClipboardData(text: email));
    
    // Show success message
    Get.snackbar(
      'Email Copied',
      'Email address copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}

  Widget _buildHeading(String headtext) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        headtext,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
 Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Color(0xFF000000)
        ),
        textAlign: TextAlign.justify,
        
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor:isDarkMode?AppColor.darkBackground:AppColor.lightBackground,
      appBar:  CustomAppBar(title:AppConstants.appBarText),body:SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            _buildHeading(AppConstants.firstHeadingText),
            _buildParagraph(AppConstants.firstParagraph),
             _buildHeading(AppConstants.secondHeadingText),
            _buildParagraph(AppConstants.secondParagraph),
             _buildHeading(AppConstants.thirdHeadingText),
            _buildParagraph(AppConstants.thirdParagraph),
             _buildHeading(AppConstants.fourthHeadingText),
            _buildParagraph(AppConstants.fourthParagraph),
            _buildHeading(AppConstants.fourthHeadingText),
            _buildParagraph(AppConstants.fourthParagraph),
            _buildHeading(AppConstants.fifthHeadingText),
            _buildParagraph(AppConstants.fifthParagraph),
            _buildHeading(AppConstants.sixthHeadingText),
            _buildParagraph(AppConstants.sixthParagraph),
            _buildHeading(AppConstants.seventhHeadingText),
            _buildParagraph(AppConstants.seventhParagraph),
             _buildHeading(AppConstants.eightHeadingText),
            _buildParagraph(AppConstants.eightParagraph),
            _buildHeading(AppConstants.ninethHeadingText),
            _buildParagraph(AppConstants.ninethParagraph),
            GestureDetector(onTap:_lauchEmail,
            child: CustomWidget.customTextWidget(text:AppConstants.polAppEmailid ,fontSize: 15,textColor: Colors.blue,textDecoration: TextDecoration.underline)
            ),
            CustomWidget.verticalSpacer(30),
             CustomWidget.verticalSpacer(10),
          ],),
        ),
      ),);
  }//
}