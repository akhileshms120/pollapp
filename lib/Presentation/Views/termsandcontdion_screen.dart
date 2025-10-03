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

  Widget _buildHeading(String headtext,bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child:CustomWidget.customTextWidget(text: headtext,textColor:AppColor.getTextColor(isDarkMode), fontSize: 20,fontWeight: FontWeight.bold )
    );
  }
 Widget _buildParagraph(String text,bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child:CustomWidget.customTextWidget(text:text,fontSize: 16,height: 1.5,textColor:AppColor.getTextColor(isDarkMode),textAlign:TextAlign.justify  )

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
      appBar:  CustomAppBar(title:AppConstants.appBarText,isDarkMode: isDarkMode,),body:SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            _buildHeading(AppConstants.firstHeadingText,isDarkMode),
            _buildParagraph(AppConstants.firstParagraph,isDarkMode),
             _buildHeading(AppConstants.secondHeadingText,isDarkMode),
            _buildParagraph(AppConstants.secondParagraph,isDarkMode),
             _buildHeading(AppConstants.thirdHeadingText,isDarkMode),
            _buildParagraph(AppConstants.thirdParagraph,isDarkMode),
             _buildHeading(AppConstants.fourthHeadingText,isDarkMode),
            _buildParagraph(AppConstants.fourthParagraph,isDarkMode),
            _buildHeading(AppConstants.fifthHeadingText,isDarkMode),
            _buildParagraph(AppConstants.fifthParagraph,isDarkMode),
            _buildHeading(AppConstants.sixthHeadingText,isDarkMode),
            _buildParagraph(AppConstants.sixthParagraph,isDarkMode),
            _buildHeading(AppConstants.seventhHeadingText,isDarkMode),
            _buildParagraph(AppConstants.seventhParagraph,isDarkMode),
             _buildHeading(AppConstants.eightHeadingText,isDarkMode),
            _buildParagraph(AppConstants.eightParagraph,isDarkMode),
            _buildHeading(AppConstants.ninethHeadingText,isDarkMode),
            _buildParagraph(AppConstants.ninethParagraph,isDarkMode),
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