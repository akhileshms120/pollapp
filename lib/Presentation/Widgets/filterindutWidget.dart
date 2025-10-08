// Reusable widget for a single filter field (Text input or Dropdown)
import 'package:flutter/material.dart';

class FilterInputTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const FilterInputTile({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Use InkWell for a tap effect
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600]),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
class FilterDataBottomSheet extends StatelessWidget {
  const FilterDataBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // The borderRadius gives the rounded corners at the top
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Essential to keep content minimal
        children: <Widget>[
          // 1. Header with Title and Close Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Data',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context), // Closes the bottom sheet
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),

          // 2. Filter Input Fields
          Flexible( // Use Flexible/Expanded if the list of inputs gets long
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Payment Date From (uses a calendar icon)
                  FilterInputTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Payment Date From',
                    trailing: const Icon(Icons.calendar_today_outlined, color: Colors.red),
                    onTap: () {
                      // Logic to show a Date Picker
                    },
                  ),
                  const Divider(height: 1, indent: 50),

                  // Payment Date To (uses a calendar icon)
                  FilterInputTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Payment Date To',
                    trailing: const Icon(Icons.calendar_today_outlined, color: Colors.red),
                    onTap: () {
                      // Logic to show a Date Picker
                    },
                  ),
                  const Divider(height: 1, indent: 50),

                  // Applicant Name (Text Input/Search)
                  const FilterInputTile(
                    icon: Icons.person_outline,
                    label: 'Applicant Name',
                  ),
                  const Divider(height: 1, indent: 50),

                  // Reference No (Text Input)
                  const FilterInputTile(
                    icon: Icons.format_list_bulleted,
                    label: 'Reference No',
                  ),
                  const Divider(height: 1, indent: 50),

                  // Transaction Id (Text Input)
                  const FilterInputTile(
                    icon: Icons.arrow_downward, // Close to the image icon
                    label: 'Transaction Id',
                  ),
                  const Divider(height: 1, indent: 50),

                  // Service Type (Dropdown)
                  const FilterInputTile(
                    icon: Icons.work_outline,
                    label: 'Service Type',
                    trailing: Icon(Icons.keyboard_arrow_down),
                  ),
                  const Divider(height: 1, indent: 50),

                  // Payment Status (Dropdown)
                  const FilterInputTile(
                    icon: Icons.credit_card,
                    label: 'Payment Status',
                    trailing: Icon(Icons.keyboard_arrow_down),
                  ),
                  const Divider(height: 1, thickness: 1),
                ],
              ),
            ),
          ),

          // 3. Footer with Action Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                // Clear Filters Button
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Logic to clear all filters
                    },
                    child: const Text('Clear Filters', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                // Apply Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic to apply filters and close the sheet
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.grey, // Matching the grey color in the image
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply', style: TextStyle(fontSize: 16)),
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