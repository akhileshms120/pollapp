import 'package:flutter/material.dart';

class GrievanceFormScreen extends StatelessWidget {
  const GrievanceFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const Color inputFieldColor = Color(0xFF6E0000);
    const Color primaryRed = Color(0xFFC00000);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // Helper method for form fields
            _buildFormInput(
              context,
              icon: const Icon(Icons.anchor_outlined, color: inputFieldColor),
              hintText: 'Police District*',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: primaryRed,
              ),
            ),
            _buildFormInput(
              context,
              icon: const Icon(
                Icons.local_police_outlined,
                color: inputFieldColor,
              ),
              hintText: 'Police Station*',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: primaryRed,
              ),
            ),
            _buildFormInput(
              context,
              icon: const Icon(Icons.person_outline, color: inputFieldColor),
              hintText: 'Name*',
            ),
            _buildFormInput(
              context,
              icon: const Icon(Icons.phone_outlined, color: inputFieldColor),
              hintText: 'Mobile Number*',
              initialValue: '9995666516',
            ),
            _buildFormInput(
              context,
              icon: const Icon(Icons.error_outline, color: inputFieldColor),
              hintText: 'Type of Grievance*',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: primaryRed,
              ),
            ),
        
            const SizedBox(height: 20),
        
            // --- Grievance Description Area ---
            TextFormField(
              maxLines: 10, // Adjust as needed, 5-10 looks right
              decoration: InputDecoration(
                hintText: 'Grievance Description*',
                contentPadding: const EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: primaryRed, width: 2.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '5000 characters left',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
        
            const SizedBox(height: 30),
        
            // --- CAPTCHA/Image Placeholder ---
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // Placeholder for the CAPTCHA image
                child: const Text(
                  '3D PTV (CAPTCHA Placeholder)',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),

        // --- Bottom Action Bar ---
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              // Clear Data Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.transparent),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text(
                    'Clear Data',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Proceed Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF334F6A,
                    ), // Dark blue/gray from the image
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper Widget for Reusable Form Fields
  Widget _buildFormInput(
    BuildContext context, {
    required Icon icon,
    required String hintText,
    Widget? trailing,
    String? initialValue,
  }) {
    // The visual style in the image is a text field with a line underneath
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
            child: icon,
          ),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                contentPadding: const EdgeInsets.only(bottom: 8.0),
                isDense: true,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC00000), width: 2.0),
                ),
                suffixIcon: trailing != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: trailing,
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
