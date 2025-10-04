import 'package:flutter/material.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';


class HomeScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:HomeScreenAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildServicesGrid(),
            const SizedBox(height: 32),
            const Text(
              'Recently Used',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRecentlyUsedRow(),
            const SizedBox(height: 32),
            const Text(
              'Emergency',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildEmergencyCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.shield_outlined), label: 'Shield'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:Colors.black,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: const [
          _ServiceItem(icon: Icons.assignment, label: 'Complaint and Registration'),
          _ServiceItem(icon: Icons.favorite_border, label: 'Certification of Non-involvment'),
          _ServiceItem(icon: Icons.attach_money, label: 'Accident GD'),
          _ServiceItem(icon: Icons.shopping_bag_outlined, label: 'Pol-Blood'),
          _ServiceItem(icon: Icons.home_outlined, label: 'FIR Download'),
          _ServiceItem(icon: Icons.work_outline, label: 'View All'),
        ],
      ),
    );
  }

  Widget _buildRecentlyUsedRow() {
    return SizedBox(
      height: 60, // Adjust height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _RecentUsedItem(
            icon: Icons.apps,
            backgroundColor: const Color(0xFFE0F7FA), // Light blue similar to image
            iconColor: Colors.teal[300],
          ),
          const SizedBox(width: 10),
          const _RecentUsedItem(icon: Icons.home_outlined),
          const SizedBox(width: 10),
          const _RecentUsedItem(icon: Icons.home_outlined),
          const SizedBox(width: 10),
          const _RecentUsedItem(icon: Icons.folder_outlined),
          const SizedBox(width: 10),
          const _RecentUsedItem(icon: Icons.more_horiz),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue.shade100, // Start color
            Colors.lightGreen.shade100, // End color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'SOS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SOS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Quick easycells action emergency contacts', // Typo from original image included
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 4),
        CustomWidget.customTextWidget(text: label)
      ],
    );
  }
}

class _RecentUsedItem extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  const _RecentUsedItem({
    required this.icon,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor ?? Colors.black),
    );
  }
}