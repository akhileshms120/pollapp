import 'package:flutter/material.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';

class HomeScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kerala Police', subtitle: 'Soft In Temperament Firm in Action',),
    );
  }
}