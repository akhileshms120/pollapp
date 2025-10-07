import 'package:flutter/material.dart';

class DonorProfilePage extends StatelessWidget {
  const DonorProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for the overall page
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildInfoCards(context),
            // Add more sections if needed, e.g., donation history, settings
          ],
        ),
      ),
    );
  }

Widget _buildInfoCards(BuildContext context) {
  return Transform.translate(
    offset: const Offset(0, -50), // Move cards up to overlap with header
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Blood Group Card
          _buildInfoCard(
            context,
            icon: Icons.bloodtype,
            iconColor: Colors.red,
            title: 'Blood Group',
            value: 'B+',
            isLargeValue: true,
          ),
          const SizedBox(height: 15),
          // Area of Convenience Card
          _buildInfoCard(
            context,
            icon: Icons.location_on,
            iconColor: Colors.blueAccent,
            title: 'Area of Convenience',
            value: 'Thiruvananthapuram',
            buttonText: 'Change', // Added an action button
            onButtonPressed: () {},
          ),
          const SizedBox(height: 15),
          // Last Blood Donated Date Card
          _buildInfoCard(
            context,
            icon: Icons.calendar_today,
            iconColor: Colors.green,
            title: 'Last Blood Donated Date',
            value: '16-05-2021',
            buttonText: 'Update', // Added an action button
            onButtonPressed: () {},
          ),
        ],
      ),
    ),
  );
}

// --- Helper Widget for individual info cards ---
Widget _buildInfoCard(
  BuildContext context, {
  required IconData icon,
  required Color iconColor,
  required String title,
  required String value,
  bool isLargeValue = false,
  String? buttonText,
  VoidCallback? onButtonPressed,
}) {
  return Card(
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: EdgeInsets.zero, // Card handles its own padding
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon and Blood Type (if large)
          if (isLargeValue)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Icon(icon, color: iconColor, size: 30),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 20),
          // Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                if (!isLargeValue) // Only show value here if not a large value
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
          // Action Button (if provided)
          if (buttonText != null)
            SizedBox(
              height: 35, // Consistent button height
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200], // Subtle button background
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: Text(buttonText),
              ),
            ),
        ],
      ),
    ),
  );
}
PreferredSizeWidget _buildAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFF1E2126), // Dark background for the app bar
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () {}, // Handle back press
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onPressed: () {}, // Handle more options
      ),
    ],
  );
}

Widget _buildProfileHeader(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(bottom: 60.0), // Space for the cards to overlap
    decoration: const BoxDecoration(
      color: Color(0xFF1E2126), // Dark background matching the app bar
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Column(
      children: [
        // Profile Icon (Blood Drop)
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.bloodtype, color: Colors.red, size: 50),
        ),
        const SizedBox(height: 10),
        // Donor Name
        const Text(
          'Akhiesh',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        // Phone Number
        const Text(
          '9995666516',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}




}