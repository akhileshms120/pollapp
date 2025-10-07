import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';

class BloodRequestPage extends StatelessWidget {
  const BloodRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }
  
 
    PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent, // Making AppBar transparent for custom design
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.pop(context),
    ),
    title: const Text('Blood Request', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.info_outline, color: Colors.black),
        onPressed: (){}
      ),
    ],
    // The main header image/text will be placed in the body for scrolling
  );
}

// ... inside the _buildBody or as a separate widget
Widget _buildHeader() {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        height: 180, // Adjust height as needed
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFDECEF), // Light background color for the header area
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the graphic like the arm and blood bag
            const SizedBox(height: 10),
            Row(
              children: [
                // Simulating the graphics
                const Icon(Icons.bloodtype, color: Colors.red, size: 40),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('DONATE BLOOD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                    Text('SAVE LIFE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
                  ],
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
      // "Request List" button
      Positioned(
        top: 10,
        right: 16,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.list, size: 18),
          label: const Text('Request List'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 2,
          ),
        ),
      ),
    ],
  );
}
  
  
  Widget _buildBody(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Details
              _buildInputField(Icons.person, 'Patient Name*'),
              _buildInputField(Icons.list_alt, 'Patient Hospital ID*'),

              // Bystander Details (Repeats from screenshot)
              _buildInputField(Icons.person, 'Bystander Name*'),
              _buildInputField(Icons.phone, 'Bystander Contact Number*'),

              // Blood Details (Using Dropdown/InkWell for simplicity)
              _buildDropdownField(Icons.bloodtype, 'Blood Group*'),
              _buildDropdownField(Icons.delete_outline, 'Blood Unit*'),

              // Date & Time
              _buildDateField(Icons.calendar_today, 'Date & Time of Blood*'),

              const SizedBox(height: 20),
              const Text('Area of Requirement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(thickness: 1, height: 10),

              // Location Details
              _buildDropdownField(Icons.location_on, 'District*'),
              _buildDropdownField(Icons.local_hospital, 'Hospital*'),
              _buildDropdownField(Icons.account_balance, 'Blood Bank*'),

              const SizedBox(height: 20),
              // CAPTCHA Field
              _buildCaptchaField(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    ),
  );
}

// --- Helper Widgets for Form Fields ---

Widget _buildInputField(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey.shade700),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    ),
  );
}

Widget _buildDropdownField(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey.shade700),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null, // Placeholder value
          hint: const Text('Select'),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: const [], // Add your actual dropdown items here
          onChanged: (String? newValue) {},
        ),
      ),
    ),
  );
}

Widget _buildDateField(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: TextFormField(
      readOnly: true, // Typically, a date field is read-only and opens a picker
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey.shade700),
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.red),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onTap: () {
        // Implement date picker logic here
      },
    ),
  );
}

Widget _buildCaptchaField() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text('5 + 5 =', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(width: 10),
      Expanded(
        child: SizedBox(
          height: 40, // Consistent height
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter sum here *',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      // Refresh icon
      InkWell(
        onTap: () {},
        child: const Icon(Icons.refresh, color: Colors.grey, size: 28),
      ),
    ],
  );
}
Widget _buildBottomButtons() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        // Clear Data Button (Text/Outlined Style)
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: const Text('Clear Data', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
        const SizedBox(width: 15),
        // Submit Button (Primary Color Style)
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF333333), // Dark color from screenshot
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    ),
  );
}
  }