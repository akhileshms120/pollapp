import 'package:flutter/material.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';

class NotifcationScreen extends StatelessWidget {
  const NotifcationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. App Bar
      appBar: CustomAppBar(elevation: 0.5,title:'Notification'),
      backgroundColor: const Color(0xFFF9F9F9), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_active, 
              color: Colors.red,
              size: 55.0,
            ),
            const SizedBox(height: 15),
            const Text(
              'No Notifications',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}