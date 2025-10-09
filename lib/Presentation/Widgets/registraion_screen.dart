import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pollapp/Domian/Entity/customScreenModel.dart';
import 'package:pollapp/Presentation/Cubit/State/complainform_state.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/complaintForm_cubit.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/progreeshome_cubit.dart';
import 'package:pollapp/Presentation/Widgets/stepper_widget.dart';

class ComplaintFormWidget extends StatelessWidget {
  const ComplaintFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get service name from arguments
    var args = Get.arguments ;
     String serviceName = "";
     String appBarTitle = "";

    if (args is Customscreenmodel) {
      appBarTitle = args.appBarTitle ?? 'Default Title';
      serviceName = args.appBarTitle ?? 'Default Service'; // Use appBarTitle as serviceName
    } else if (args is String) {
      serviceName = args;
      appBarTitle = args;
    } else {
      serviceName = 'Default Service';
      appBarTitle = 'Default Title';
    }


    // Get the ServiceProgressCubit from the parent context
    final serviceProgressCubit = context.read<ServiceProgressCubit>();

    return BlocProvider(
      create: (context) => ComplaintFormCubit(
        serviceProgressCubit: serviceProgressCubit,
        serviceName: serviceName,
      ),
      child: BlocConsumer<ComplaintFormCubit, ComplaintFormState>(
        listener: (context, state) {
          if (state is ComplaintFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ComplaintFormSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate back after success
            Future.delayed(const Duration(seconds: 2), () {
              Get.back();
            });
          }
        },
        builder: (context, state) {
          final cubit = context.read<ComplaintFormCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFF7F9FC),
            appBar: AppBar(
              title: Text(
                appBarTitle,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    ModernStepper(
                      steps: ComplaintFormCubit.steps,
                      currentStep: state.currentStep,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildStepContent(context, state),
                      ),
                    ),
                  ],
                ),
                // Loading overlay
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Processing...'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            bottomNavigationBar: _buildBottomBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ComplaintFormState state) {
    final cubit = context.read<ComplaintFormCubit>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (state.currentStep > 0)
            OutlinedButton.icon(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              label: const Text("Previous"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Colors.black38),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
              onPressed: state.isLoading ? null : () => cubit.previousStep(),
            )
          else
            const SizedBox(width: 90),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            label: Text(
              state.currentStep == ComplaintFormCubit.steps.length - 1
                  ? "Submit"
                  : "Next",
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
            onPressed: state.isLoading ? null : () => cubit.nextStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, ComplaintFormState state) {
    switch (state.currentStep) {
      case 0:
        return _PersonalInfoForm();
      case 1:
        return _PermanentAddressForm();
      case 2:
        return _PresentAddressForm();
      case 3:
        return _ComplaintDetailsForm();
      case 4:
        return _RespondentDetailsForm();
      default:
        return const SizedBox.shrink();
    }
  }
}

// Personal Info Form Widget
class _PersonalInfoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintFormCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            "Name*",
            Icons.person_outline,
            onChanged: (value) => cubit.updateFormData('name', value),
          ),
          const SizedBox(height: 16),
          _buildDatePickerField(
            context,
            "Date of Birth*",
            Icons.calendar_today_rounded,
            onDateSelected: (date) => cubit.updateFormData('dob', date),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            "Age*",
            Icons.cake_outlined,
            keyboardType: TextInputType.number,
            onChanged: (value) => cubit.updateFormData('age', value),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            "Gender*",
            Icons.male_rounded,
            ["Male", "Female", "Other"],
            onChanged: (value) => cubit.updateFormData('gender', value),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            "Caste Category",
            Icons.group_outlined,
            ["General", "OBC", "SC", "ST"],
            onChanged: (value) => cubit.updateFormData('caste', value),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            "Mobile Number*",
            Icons.phone_android_rounded,
            prefixText: "+91 ",
            keyboardType: TextInputType.phone,
            onChanged: (value) => cubit.updateFormData('mobile', value),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            "Relative Name*",
            Icons.person_outline,
            onChanged: (value) => cubit.updateFormData('relativeName', value),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            "Relative Type*",
            Icons.family_restroom_rounded,
            ["Father", "Mother", "Brother", "Sister", "Spouse", "Other"],
            onChanged: (value) => cubit.updateFormData('relativeType', value),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            "ID Type*",
            Icons.credit_card_rounded,
            ["AADHAR CARD (UIDAI)", "VOTER ID", "PAN CARD", "PASSPORT"],
            onChanged: (value) => cubit.updateFormData('idType', value),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            "ID Card Number*",
            Icons.numbers_rounded,
            suffixIcon: Icons.camera_alt_rounded,
            onChanged: (value) => cubit.updateFormData('idNumber', value),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    String? prefixText,
    IconData? suffixIcon,
    Function(String)? onChanged,
  }) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
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

  Widget _buildDropdownField(
    String label,
    IconData icon,
    List<String> items, {
    Function(String?)? onChanged,
  }) {
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
            if (onChanged != null) onChanged(value);
          },
        );
      },
    );
  }

  Widget _buildDatePickerField(
    BuildContext context,
    String label,
    IconData icon, {
    Function(DateTime)? onDateSelected,
  }) {
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
            suffixIcon: const Icon(Icons.calendar_month_rounded,
                color: Colors.redAccent),
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
              if (onDateSelected != null) onDateSelected(pickedDate);
            }
          },
        );
      },
    );
  }
}

// Permanent Address Form
class _PermanentAddressForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintFormCubit>();
    final state = context.watch<ComplaintFormCubit>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PersonalInfoForm()._buildTextField(
            "House Number*",
            Icons.home_outlined,
            onChanged: (value) =>
                cubit.updateFormData('permanentHouseNumber', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "House Name*",
            Icons.house_rounded,
            onChanged: (value) =>
                cubit.updateFormData('permanentHouseName', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Street Name*",
            Icons.signpost_outlined,
            onChanged: (value) =>
                cubit.updateFormData('permanentStreetName', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Locality",
            Icons.location_on_outlined,
            onChanged: (value) =>
                cubit.updateFormData('permanentLocality', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "City/ Town/ Village Name*",
            Icons.location_city,
            onChanged: (value) => cubit.updateFormData('permanentCity', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Pin Code*",
            Icons.pin_outlined,
            keyboardType: TextInputType.number,
            onChanged: (value) =>
                cubit.updateFormData('permanentPinCode', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Country*",
            Icons.public,
            ["India", "Other"],
            onChanged: (value) =>
                cubit.updateFormData('permanentCountry', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "State*",
            Icons.account_balance_outlined,
            ["Kerala", "Tamil Nadu", "Karnataka", "Goa"],
            onChanged: (value) =>
                cubit.updateFormData('permanentState', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Police District*",
            Icons.anchor_rounded,
            ["THIRUVANANTHAPURAM CITY", "KOLLAM", "ERNAKULAM", "KOZHIKODE"],
            onChanged: (value) =>
                cubit.updateFormData('permanentPoliceDistrict', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Police Station*",
            Icons.shield_outlined,
            ["KARAMANA", "PEROORKADA", "PETTAH", "FORT"],
            onChanged: (value) =>
                cubit.updateFormData('permanentPoliceStation', value),
          ),
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
                  value: state.isSameAddress,
                  activeColor: const Color(0xFF2E3192),
                  onChanged: (value) => cubit.toggleSameAddress(value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// Present Address Form
class _PresentAddressForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintFormCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PersonalInfoForm()._buildTextField(
            "House Number*",
            Icons.home_outlined,
            onChanged: (value) =>
                cubit.updateFormData('presentHouseNumber', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "House Name*",
            Icons.house_rounded,
            onChanged: (value) =>
                cubit.updateFormData('presentHouseName', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Street Name*",
            Icons.signpost_outlined,
            onChanged: (value) =>
                cubit.updateFormData('presentStreetName', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Locality",
            Icons.location_on_outlined,
            onChanged: (value) =>
                cubit.updateFormData('presentLocality', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "City/ Town/ Village Name*",
            Icons.location_city,
            onChanged: (value) => cubit.updateFormData('presentCity', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Pin Code*",
            Icons.pin_outlined,
            keyboardType: TextInputType.number,
            onChanged: (value) =>
                cubit.updateFormData('presentPinCode', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Country*",
            Icons.public,
            ["India", "Other"],
            onChanged: (value) =>
                cubit.updateFormData('presentCountry', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "State*",
            Icons.account_balance_outlined,
            ["Kerala", "Tamil Nadu", "Karnataka", "Goa"],
            onChanged: (value) => cubit.updateFormData('presentState', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Police District*",
            Icons.anchor_rounded,
            ["THIRUVANANTHAPURAM CITY", "KOLLAM", "ERNAKULAM", "KOZHIKODE"],
            onChanged: (value) =>
                cubit.updateFormData('presentPoliceDistrict', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Police Station*",
            Icons.shield_outlined,
            ["KARAMANA", "PEROORKADA", "PETTAH", "FORT"],
            onChanged: (value) =>
                cubit.updateFormData('presentPoliceStation', value),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// Complaint Details Form
class _ComplaintDetailsForm extends StatefulWidget {
  @override
  State<_ComplaintDetailsForm> createState() => _ComplaintDetailsFormState();
}

class _ComplaintDetailsFormState extends State<_ComplaintDetailsForm> {
  bool isDateKnown = false;
  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintFormCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PersonalInfoForm()._buildDropdownField(
            "Complaint Nature*",
            Icons.description_outlined,
            ["Theft", "Assault", "Fraud", "Harassment", "Cyber Crime", "Other"],
            onChanged: (value) =>
                cubit.updateFormData('complaintNature', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Place of Incident*",
            Icons.place_outlined,
            onChanged: (value) =>
                cubit.updateFormData('placeOfIncident', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Police District*",
            Icons.anchor_rounded,
            ["THIRUVANANTHAPURAM CITY", "KOLLAM", "ERNAKULAM", "KOZHIKODE"],
            onChanged: (value) =>
                cubit.updateFormData('incidentPoliceDistrict', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Police Station*",
            Icons.shield_outlined,
            ["KARAMANA", "PEROORKADA", "PETTAH", "FORT"],
            onChanged: (value) =>
                cubit.updateFormData('incidentPoliceStation', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildDropdownField(
            "Office to file Complaint*",
            Icons.apartment_rounded,
            [
              "Commissioner Office",
              "Superintendent Office",
              "Circle Office",
              "Local Station"
            ],
            onChanged: (value) =>
                cubit.updateFormData('officeToFile', value),
          ),
          const SizedBox(height: 24),
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
                    cubit.updateFormData('isDateKnown', value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (isDateKnown)
            TextField(
              controller: dateController,
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    dateController.text =
                        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                  });
                  cubit.updateFormData('incidentDate', pickedDate);
                }
              },
            ),
          if (isDateKnown) const SizedBox(height: 16),
          TextField(
            maxLines: 5,
            onChanged: (value) =>
                cubit.updateFormData('complaintDescription', value),
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
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle document upload
              },
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
  }
}

// Respondent Details Form
class _RespondentDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintFormCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Respondent Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _PersonalInfoForm()._buildTextField(
            "Respondent Name",
            Icons.person_outline,
            onChanged: (value) =>
                cubit.updateFormData('respondentName', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Respondent Address",
            Icons.location_on_outlined,
            onChanged: (value) =>
                cubit.updateFormData('respondentAddress', value),
          ),
          const SizedBox(height: 16),
          _PersonalInfoForm()._buildTextField(
            "Respondent Contact",
            Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            onChanged: (value) =>
                cubit.updateFormData('respondentContact', value),
          ),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            onChanged: (value) =>
                cubit.updateFormData('additionalDetails', value),
            decoration: InputDecoration(
              labelText: "Additional Details",
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}