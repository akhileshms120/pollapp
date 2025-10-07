import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';

// This widget defines the content that will be displayed INSIDE the bottom sheet.
class PolBloodBottomSheetContent extends StatelessWidget {
  const PolBloodBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2C2C2C), // Background color of the bottom sheet
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content height
          children: <Widget>[
            // Header with icon, title, and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  Icons.bloodtype, // Blood drop icon
                  color: Colors.red,
                  size: 28,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Pol-Blood',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 25), // Space below header

            // Blood Request Button
            SizedBox(
              width: double.infinity, // Full width button
              height: 60, // Taller button
              child: ElevatedButton.icon(
                onPressed: () {
              Get.toNamed(RoutesName.bloodRequestScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700], // Red color for blood request
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                icon:Image.asset('assets/images/new/services/blood-request.png',color: Colors.white,),
               
                label: const Text(
                  'Blood Request',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15), // Space between buttons

            // Donor Registration Button
            SizedBox(
              width: double.infinity, // Full width button
              height: 60, // Taller button
              child: ElevatedButton.icon(
                onPressed: () {
                   Get.toNamed(RoutesName.donorRegistration);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700], // Blue color for donor registration
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                icon: Image.asset("assets/images/new/services/blood-donate.png",color: Colors.white,),
                //const Icon(Icons.favorite, size: 28), // Heart icon for donor
                label: const Text(
                  'Donor Registration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10), // Padding at the bottom
          ],
        ),
      ),
    );
  }
}