import 'package:flutter/material.dart';



class FirDownloadScreen extends StatefulWidget {
  const FirDownloadScreen({super.key});

  @override
  State<FirDownloadScreen> createState() => _FirDownloadScreenState();
}

class _FirDownloadScreenState extends State<FirDownloadScreen> {
  // State to manage which view is active
  bool _isAdvancedSearch = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Download'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Clean, flat app bar
        actions: [
          // Elegant button to switch to advanced search
          if (!_isAdvancedSearch)
            TextButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Advanced Search'),
              onPressed: () {
                setState(() {
                  _isAdvancedSearch = true;
                });
              },
            ),
          // Back button for advanced search
          if (_isAdvancedSearch)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _isAdvancedSearch = false;
                });
              },
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Conditionally show the appropriate form
            _isAdvancedSearch 
                ? const AdvancedSearchForm()
                : const BasicSearchForm(),
          ],
        ),
      ),
      // Bottom persistent action bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Clear Data button
            TextButton(
              onPressed: () { /* Handle Clear Data */ },
              child: const Text(
                'Clear Data',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            // Submit button
            ElevatedButton(
              onPressed: () { /* Handle Submit */ },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Widgets for the two forms
// ------------------------------------------------------------------

class BasicSearchForm extends StatelessWidget {
  const BasicSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FIR Number Field
        _buildTextField(
          label: 'FIR Number*',
          icon: Icons.article_outlined,
          hint: 'Enter FIR Number',
        ),
        const SizedBox(height: 15),
        // Year of Registration Dropdown
        _buildDropdownField(
          label: 'Year of Registration*',
          icon: Icons.list_alt,
          items: const ['2023', '2024', '2025'], // Example data
          selectedValue: '2025',
          onChanged: (val) { /* Handle selection */ },
        ),
        const SizedBox(height: 15),
        // Police District Dropdown
        _buildDropdownField(
          label: 'Police District*',
          icon: Icons.anchor, // Using the 'anchor' icon from the image
          items: const ['District A', 'District B'],
          selectedValue: 'District A',
          onChanged: (val) { /* Handle selection */ },
        ),
        const SizedBox(height: 15),
        // Police Station Dropdown
        _buildDropdownField(
          label: 'Police Station*',
          icon: Icons.local_police_outlined,
          items: const ['Station X', 'Station Y'],
          selectedValue: 'Station X',
          onChanged: (val) { /* Handle selection */ },
        ),
        const SizedBox(height: 15),
        // Captcha Field
        _buildCaptchaField(context),
      ],
    );
  }
}

class AdvancedSearchForm extends StatelessWidget {
  const AdvancedSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FIR Number Field (Optional here)
        _buildTextField(
          label: 'FIR Number',
          icon: Icons.article_outlined,
          hint: 'Enter optional FIR Number',
          required: false,
        ),
        const SizedBox(height: 15),
        // Year of Registration Dropdown
        _buildDropdownField(
          label: 'Year of Registration',
          icon: Icons.list_alt,
          items: const ['2023', '2024', '2025'], // Example data
          selectedValue: '2025',
          onChanged: (val) { /* Handle selection */ },
          required: false,
        ),
        const SizedBox(height: 15),
        // Name of accused
        _buildTextField(
          label: 'Name of accused',
          icon: Icons.person_outline,
          hint: 'Enter name',
          required: false,
        ),
        const SizedBox(height: 15),
        // Police District Dropdown (Required here)
        _buildDropdownField(
          label: 'Police District*',
          icon: Icons.anchor,
          items: const ['District A', 'District B'],
          selectedValue: 'District A',
          onChanged: (val) { /* Handle selection */ },
        ),
        const SizedBox(height: 15),
        // Police Station Dropdown (Required here)
        _buildDropdownField(
          label: 'Police Station*',
          icon: Icons.local_police_outlined,
          items: const ['Station X', 'Station Y'],
          selectedValue: 'Station X',
          onChanged: (val) { /* Handle selection */ },
        ),
        const SizedBox(height: 15),
        // Starting Date
        _buildDateField(
          label: 'Starting Date*',
          icon: Icons.calendar_today_outlined,
          onTap: () { /* Show date picker */ },
        ),
        const SizedBox(height: 15),
        // Ending Date
        _buildDateField(
          label: 'Ending Date*',
          icon: Icons.calendar_today_outlined,
          onTap: () { /* Show date picker */ },
        ),
        const SizedBox(height: 10),
        // Max period info
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.red, size: 18),
                SizedBox(width: 5),
                Text(
                  'Maximum period 7 days',
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// Reusable UI Components
// ------------------------------------------------------------------

Widget _buildTextField({
  required String label,
  required IconData icon,
  String hint = '',
  bool required = true,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: required ? label : label, // Label includes asterisk if required
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
    ),
  );
}

Widget _buildDropdownField({
  required String label,
  required IconData icon,
  required List<String> items,
  String? selectedValue,
  required ValueChanged<String?> onChanged,
  bool required = true,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: required ? label : label,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
    ),
    value: selectedValue,
    icon: const Icon(Icons.keyboard_arrow_down),
    isExpanded: true,
    items: items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: onChanged,
  );
}

Widget _buildDateField({
  required String label,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        suffixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.deepPurple),
      ),
      child: const Text(
        'Select Date', // Placeholder text
        style: TextStyle(color: Colors.black54),
      ),
    ),
  );
}

Widget _buildCaptchaField(BuildContext context) {
  // A custom field for the Captcha, combining an image and a text field
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          border: Border.all(color: Colors.deepPurple.shade200),
          borderRadius: BorderRadius.circular(5.0),
        ),
        // Placeholder for the CAPTCHA image/text
        child: Center(
          child: Text(
            '8O98Y3', // Text representation of the image captcha
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      Row(
        children: [
          Expanded(
            child: _buildTextField(
              label: 'Captcha code*',
              icon: Icons.security_outlined,
              hint: 'Enter the code above',
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.deepPurple, size: 30),
            onPressed: () { /* Refresh captcha */ },
          ),
        ],
      ),
    ],
  );
}