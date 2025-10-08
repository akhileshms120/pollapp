import 'package:flutter/material.dart';

class ArrestSearchScreen extends StatelessWidget {
  const ArrestSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color inputFieldColor = Color(0xFF6E0000);
    const Color primaryRed = Color(0xFFC00000);
    const Color buttonColor = Color(0xFF334F6A);

    return
       SafeArea(
        child: Container(
          color: const Color(0xFFF6F8FB),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------- Form Section ----------
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildFormInput(
                      icon: const Icon(Icons.person_outline, color: inputFieldColor),
                      hintText: 'Name of Person',
                    ),
                    _buildFormInput(
                      icon: const Icon(Icons.anchor_outlined, color: inputFieldColor),
                      hintText: 'Police District*',
                      trailing: const Icon(Icons.keyboard_arrow_down, color: primaryRed),
                    ),
                    _buildFormInput(
                      icon: const Icon(Icons.local_police_outlined, color: inputFieldColor),
                      hintText: 'Police Station*',
                      trailing: const Icon(Icons.keyboard_arrow_down, color: primaryRed),
                    ),
                    _buildFormInput(
                      icon: const Icon(Icons.calendar_today_outlined, color: inputFieldColor, size: 20),
                      hintText: 'Starting Date*',
                      trailing: const Icon(Icons.calendar_today_outlined, color: primaryRed, size: 20),
                    ),
                    _buildFormInput(
                      icon: const Icon(Icons.calendar_today_outlined, color: inputFieldColor, size: 20),
                      hintText: 'Ending Date*',
                      trailing: const Icon(Icons.calendar_today_outlined, color: primaryRed, size: 20),
                    ),
        
                    // --- Info Row ---
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: primaryRed, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Maximum period 7 days',
                            style: TextStyle(color: primaryRed, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 10),
        
              // ---------- Buttons Section ----------
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
                  children: [
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  
  }

  // ---------- Helper Widget ----------
  Widget _buildFormInput({
    required Icon icon,
    required String hintText,
    Widget? trailing,
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
            child: icon,
          ),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              readOnly: trailing != null,
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
                suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
