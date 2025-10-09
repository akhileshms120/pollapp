import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/complainform_state.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/progreeshome_cubit.dart';


class ComplaintFormCubit extends Cubit<ComplaintFormState> {
  final ServiceProgressCubit serviceProgressCubit;
  final String serviceName;

  ComplaintFormCubit({
    required this.serviceProgressCubit,
    required this.serviceName,
  }) : super(const ComplaintFormInitial()) {
    // Initialize service with total steps
    serviceProgressCubit.initializeService(serviceName, steps.length);
  }

  static const List<String> steps = [
    "Personal Info",
    "Permanent Address",
    "Present Address",
    "Complaint Details",
    "Respondent Details"
  ];

  void updateFormData(String key, dynamic value) {
    final updatedData = Map<String, dynamic>.from(state.formData);
    updatedData[key] = value;
    
    emit(ComplaintFormStepChanged(
      currentStep: state.currentStep,
      isSameAddress: state.isSameAddress,
      formData: updatedData,
    ));
  }

  void toggleSameAddress(bool value) {
    emit(ComplaintFormStepChanged(
      currentStep: state.currentStep,
      isSameAddress: value,
      formData: state.formData,
    ));
  }

  Future<void> nextStep() async {
    // Show loading
    emit(ComplaintFormLoading(
      currentStep: state.currentStep,
      isSameAddress: state.isSameAddress,
      formData: state.formData,
    ));

    // Simulate validation/processing delay
    await Future.delayed(const Duration(seconds: 1));

    // Validate current step data
    final validationError = _validateCurrentStep();
    if (validationError != null) {
      emit(ComplaintFormError(
        currentStep: state.currentStep,
        isSameAddress: state.isSameAddress,
        formData: state.formData,
        error: validationError,
      ));
      return;
    }

    // Handle navigation logic
    int nextStepIndex = state.currentStep;
    
    if (state.currentStep == 1 && state.isSameAddress) {
      nextStepIndex = 3; // Skip present address if same as permanent
    } else if (state.currentStep < steps.length - 1) {
      nextStepIndex = state.currentStep + 1;
    } else if (state.currentStep == steps.length - 1) {
      // Submit form
      await _submitForm();
      return;
    }

    // Update progress in ServiceProgressCubit
    serviceProgressCubit.updateServiceProgress(
      serviceName,
      nextStepIndex + 1, // +1 because steps are 0-indexed
      steps.length,
    );

    emit(ComplaintFormStepChanged(
      currentStep: nextStepIndex,
      isSameAddress: state.isSameAddress,
      formData: state.formData,
    ));
  }

  void previousStep() {
    int prevStepIndex = state.currentStep;
    
    if (state.currentStep == 3 && state.isSameAddress) {
      prevStepIndex = 1;
    } else if (state.currentStep > 0) {
      prevStepIndex = state.currentStep - 1;
    }

    // Update progress in ServiceProgressCubit
    serviceProgressCubit.updateServiceProgress(
      serviceName,
      prevStepIndex + 1,
      steps.length,
    );

    emit(ComplaintFormStepChanged(
      currentStep: prevStepIndex,
      isSameAddress: state.isSameAddress,
      formData: state.formData,
    ));
  }

  String? _validateCurrentStep() {
    // Add your validation logic here
    return null;
  }

  Future<void> _submitForm() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mark service as complete
      serviceProgressCubit.completeService(serviceName);
      
      emit(ComplaintFormSubmitted(
        currentStep: state.currentStep,
        isSameAddress: state.isSameAddress,
        formData: state.formData,
        message: 'Complaint submitted successfully!',
      ));
    } catch (e) {
      emit(ComplaintFormError(
        currentStep: state.currentStep,
        isSameAddress: state.isSameAddress,
        formData: state.formData,
        error: 'Failed to submit complaint: $e',
      ));
    }
  }
}