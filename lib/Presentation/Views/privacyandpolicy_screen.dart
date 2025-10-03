import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';

class PrivacyandpolicyScreen extends StatelessWidget {
  const PrivacyandpolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
  final Brightness brightness = Theme.of(context).brightness;
  final bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:isDarkMode?AppColor.darkBackground:AppColor.lightBackground,
      appBar: CustomAppBar(title:AppConstants.privacyandpolicyScreentitle,isDarkMode: isDarkMode,),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(20),
        child: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomWidget.buildHeading(AppConstants.pfirstHeadingText, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.pfirstParagraph, isDarkMode),
           CustomWidget.buildHeading(AppConstants.psecondHeadingText, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.psecondParagraph, isDarkMode)
          ],
        )),
      ),
      
      );
      
    
  }
}