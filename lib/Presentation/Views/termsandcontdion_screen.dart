import 'package:flutter/material.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';


class TermsandcontdionScreen extends StatelessWidget {
  const TermsandcontdionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppbar.customAppBar(title: "Terms and Condtion"));
  }
}