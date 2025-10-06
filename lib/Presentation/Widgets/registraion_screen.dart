import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollapp/Presentation/Widgets/stepper_widget.dart';

class ComplaintFormWidget extends StatefulWidget {
  const ComplaintFormWidget({super.key});

  @override
  State<ComplaintFormWidget> createState() =>
      _complaintFormWidgetState();
}

class _complaintFormWidgetState
    extends State<ComplaintFormWidget> {
        final String appBarTitle = Get.arguments ?? 'Default Title';
      bool isSameAddress = false;

  int currentStep = 0;

  final steps = [
    "Personal Info",
    "Permanent Address",
    "Present Address",
    "Complaint Details",
    "Respondent Details"
  ];

  // Example controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void nextStep() {
  setState(() {
  
    if (currentStep == 1 && isSameAddress) {
      currentStep = 3; 
    } else if (currentStep < steps.length - 1) {
      currentStep++;
    }
  });
}


  void prevStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInfoForm();
      case 1:
        return _buildPermanentAddressForm();
      case 2:
        return _buildPresentAddressForm();
      case 3:
        return _buildComplaintDetailsForm();
      case 4:
        return _buildRespondentDetailsForm();
      default:
        return const SizedBox.shrink();
    }
  }

 Widget _buildPersonalInfoForm() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          _buildTextField("Name*", Icons.person_outline),
          const SizedBox(height: 16),
        _buildDatePickerField("Date of Birth*", Icons.calendar_today_rounded),
        const SizedBox(height: 16),
        _buildTextField("Age*", Icons.cake_outlined, keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildDropdownField("Gender*", Icons.male_rounded, ["Male", "Female", "Other"]),
        const SizedBox(height: 16),
        _buildDropdownField("Caste Category", Icons.group_outlined, ["General", "OBC", "SC", "ST"]),
        const SizedBox(height: 16),
        _buildTextField("Mobile Number*", Icons.phone_android_rounded, prefixText: "+91 "),
        const SizedBox(height: 16),
        _buildTextField("Relative Name*", Icons.person_outline),
        const SizedBox(height: 16),
        _buildDropdownField("Relative Type*", Icons.family_restroom_rounded, [
          "Father",
          "Mother",
          "Brother",
          "Sister",
          "Spouse",
          "Other"
        ]),
        const SizedBox(height: 16),
        _buildDropdownField("ID Type*", Icons.credit_card_rounded, [
          "AADHAR CARD (UIDAI)",
          "VOTER ID",
          "PAN CARD",
          "PASSPORT"
        ]),
        const SizedBox(height: 16),
        _buildTextField("ID Card Number*", Icons.numbers_rounded, suffixIcon: Icons.camera_alt_rounded),
        const SizedBox(height: 30),
      ],
    ),
  );
}

Widget _buildTextField(String label, IconData icon,
    {TextInputType? keyboardType, String? prefixText, IconData? suffixIcon}) {
  return TextField(
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey[700]),
      prefixText: prefixText,
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: Colors.grey[700])
          : null,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black26),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}

Widget _buildDropdownField(String label, IconData icon, List<String> items) {
  String? selectedValue;
  return StatefulBuilder(
    builder: (context, setState) {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[700]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        value: selectedValue,
        items: items
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (value) {
          setState(() => selectedValue = value);
        },
      );
    },
  );
}

Widget _buildDatePickerField(String label, IconData icon) {
  DateTime? selectedDate;
  TextEditingController controller = TextEditingController();

  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[700]),
          suffixIcon:
              const Icon(Icons.calendar_month_rounded, color: Colors.redAccent),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(1995),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              selectedDate = pickedDate;
              controller.text =
                  "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
            });
          }
        },
      );
    },
  );
}

Widget _buildPermanentAddressForm() {
  return StatefulBuilder(
    builder: (context, setStateSB) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("House Number*", Icons.home_outlined),
            const SizedBox(height: 16),
            _buildTextField("House Name*", Icons.house_rounded),
            const SizedBox(height: 16),
            _buildTextField("Street Name*", Icons.signpost_outlined),
            const SizedBox(height: 16),
            _buildTextField("Locality", Icons.location_on_outlined),
            const SizedBox(height: 16),
            _buildTextField("City/ Town/ Village Name*", Icons.location_city),
            const SizedBox(height: 16),
            _buildTextField("Pin Code*", Icons.pin_outlined,
                keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _buildDropdownField("Country*", Icons.public, ["India", "Other"]),
            const SizedBox(height: 16),
            _buildDropdownField("State*", Icons.account_balance_outlined,
                ["Kerala", "Tamil Nadu", "Karnataka", "Goa"]),
            const SizedBox(height: 16),
            _buildDropdownField("Police District*", Icons.anchor_rounded,
                ["THIRUVANANTHAPURAM CITY", "KOLLAM", "ERNAKULAM", "KOZHIKODE"]),
            const SizedBox(height: 16),
            _buildDropdownField("Police Station*", Icons.shield_outlined,
                ["KARAMANA", "PEROORKADA", "PETTAH", "FORT"]),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Permanent address is same as present address?",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                  Switch(
                    value: isSameAddress,
                    activeColor: const Color(0xFF2E3192),
                    onChanged: (value) {
                      setState(() {
                        isSameAddress = value; // update global variable
                      });
                      setStateSB(() {}); // update UI of this StatefulBuilder
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    },
  );
}

  Widget _buildPresentAddressForm() {
    return  StatefulBuilder(
    builder: (context, setStateSB) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("House Number*", Icons.home_outlined),
            const SizedBox(height: 16),
            _buildTextField("House Name*", Icons.house_rounded),
            const SizedBox(height: 16),
            _buildTextField("Street Name*", Icons.signpost_outlined),
            const SizedBox(height: 16),
            _buildTextField("Locality", Icons.location_on_outlined),
            const SizedBox(height: 16),
            _buildTextField("City/ Town/ Village Name*", Icons.location_city),
            const SizedBox(height: 16),
            _buildTextField("Pin Code*", Icons.pin_outlined,
                keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _buildDropdownField("Country*", Icons.public, ["India", "Other"]),
            const SizedBox(height: 16),
            _buildDropdownField("State*", Icons.account_balance_outlined,
                ["Kerala", "Tamil Nadu", "Karnataka", "Goa"]),
            const SizedBox(height: 16),
            _buildDropdownField("Police District*", Icons.anchor_rounded,
                ["THIRUVANANTHAPURAM CITY", "KOLLAM", "ERNAKULAM", "KOZHIKODE"]),
            const SizedBox(height: 16),
            _buildDropdownField("Police Station*", Icons.shield_outlined,
                ["KARAMANA", "PEROORKADA", "PETTAH", "FORT"]),
       
        
                  ]));
  });
  }

Widget _buildComplaintDetailsForm() {
  bool isDateKnown = false;
  DateTime? selectedDate;
  TextEditingController controller = TextEditingController();

  return StatefulBuilder(
    builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdownField(
              "Complaint Nature*",
              Icons.description_outlined,
              [
                "Theft",
                "Assault",
                "Fraud",
                "Harassment",
                "Cyber Crime",
                "Other"
              ],
            ),
            const SizedBox(height: 16),

            _buildTextField("Place of Incident*", Icons.place_outlined),
            const SizedBox(height: 16),

            _buildDropdownField(
              "Police District*",
              Icons.anchor_rounded,
              [
                "THIRUVANANTHAPURAM CITY",
                "KOLLAM",
                "ERNAKULAM",
                "KOZHIKODE"
              ],
            ),
            const SizedBox(height: 16),

            _buildDropdownField(
              "Police Station*",
              Icons.shield_outlined,
              ["KARAMANA", "PEROORKADA", "PETTAH", "FORT"],
            ),
            const SizedBox(height: 16),

            _buildDropdownField(
              "Office to file Complaint*",
              Icons.apartment_rounded,
              [
                "Commissioner Office",
                "Superintendent Office",
                "Circle Office",
                "Local Station"
              ],
            ),
            const SizedBox(height: 24),

            // --- Date of Incident Known Toggle ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Is Date of Incident Known?",
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                  ),
                  Switch(
                    value: isDateKnown,
                    activeColor: const Color(0xFF2E3192),
                    onChanged: (value) {
                      setState(() => isDateKnown = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Date Picker Shown Conditionally ---
            if (isDateKnown)
              TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date of Incident*",
                  prefixIcon: const Icon(Icons.calendar_month_rounded,
                      color: Colors.redAccent),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                      controller.text =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                    });
                  }
                },
              ),
            if (isDateKnown) const SizedBox(height: 16),

            // --- Complaint Description ---
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Complaint Description*",
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            // --- Support Documents Button ---
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline_rounded),
                label: const Text("Support Documents"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.white,
                  elevation: 1,
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    },
  );
}


  Widget _buildRespondentDetailsForm() {
    return const Center(child: Text("Respondent Details Form Fields Here"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title:  Text(
          appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,   //2 month  june 2024 to june 2025 13 month
        elevation: 1,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          ModernStepper(
            steps: steps,
            currentStep: currentStep,
          ),
          Expanded(
            child: SingleChildScrollView(child: _buildStepContent()),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentStep > 0)
              OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                label: const Text("Previous"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Colors.black38),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12),
                ),
                onPressed: prevStep,
              )
            else
              const SizedBox(width: 90),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              label: Text(
                currentStep == steps.length - 1 ? "Submit" : "Next",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3192),
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: nextStep,
            ),
          ],
        ),
      ),
    );
  }
}
