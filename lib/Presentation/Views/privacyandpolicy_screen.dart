import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';

class PrivacyandpolicyScreen extends StatelessWidget {
  const PrivacyandpolicyScreen({super.key});

Widget _buildPermissionItem(String number, String title, String purpose) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. $title',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.indigo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 4.0),
            child: Text(
              purpose,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }






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
          CustomWidget.buildParagraph(AppConstants.pfirstParagraph,isDarkMode),
           CustomWidget.buildHeading(AppConstants.psecondHeadingText, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.psecondParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.pthirdParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.pfourthParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.pfifthParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.psixthParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.pseventhParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.peightParagraph, isDarkMode),
           CustomWidget.buildHeading(AppConstants.pninthHeadingText, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.pninthParagraph, isDarkMode),
          CustomWidget.buildParagraph(AppConstants.ptenthParagraph, isDarkMode),
          
          
         // CustomWidget.buildParagraph(AppConstants.psecondParagraph, isDarkMode)
          ],
        )),
      ),
      
      );
      
    
  }
}