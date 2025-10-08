import 'package:flutter/material.dart';

class TrackMyTripScreen extends StatelessWidget {
  const TrackMyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors (consistent and neutral palette)
    const Color cardBorderColor = Color(0xFFE0E0E0);
    const Color iconColor = Color(0xFF6A6A6A);
    const Color primaryButtonColor = Color(0xFF5D5D5D); // Dark gray
    const Color continueButtonColor = Color(0xFFDCDCDC); // Light gray

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Upload Photo Cards Row ---
            Row(
              children: [
                Expanded(
                  child: _buildUploadCard(
                    icon: Icons.person_add_alt_1_outlined,
                    label: 'Add Driver Photo',
                    borderColor: cardBorderColor,
                    iconColor: iconColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildUploadCard(
                    icon: Icons.directions_car_outlined,
                    label: 'Add Vehicle Photo',
                    borderColor: cardBorderColor,
                    iconColor: iconColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // --- Empty State Illustration & Message ---
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _IllustrationPlaceholder(),
                  const SizedBox(height: 24),
                  const Text(
                    'No contacts found.\nAdd contacts to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Add Contact',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // --- Continue Button (optional bottom action) ---
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: continueButtonColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Upload Card Widget ---
  Widget _buildUploadCard({
    required IconData icon,
    required String label,
    required Color borderColor,
    required Color iconColor,
  }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: iconColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// --- Illustration Placeholder Widget ---
class _IllustrationPlaceholder extends StatelessWidget {
  const _IllustrationPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF1B7B7), width: 1.2),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x20F1B7B7),
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Center(
        child: Text('📄😊', style: TextStyle(fontSize: 42)),
      ),
    );
  }
}
