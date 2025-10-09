import 'package:equatable/equatable.dart';

abstract class ComplaintFormState extends Equatable {
  final int currentStep;
  final bool isSameAddress;
  final Map<String, dynamic> formData;
  final bool isLoading;

  const ComplaintFormState({
    required this.currentStep,
    required this.isSameAddress,
    required this.formData,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [currentStep, isSameAddress, formData, isLoading];
}

class ComplaintFormInitial extends ComplaintFormState {
  const ComplaintFormInitial()
      : super(
          currentStep: 0,
          isSameAddress: false,
          formData: const {},
        );
}

class ComplaintFormStepChanged extends ComplaintFormState {
  const ComplaintFormStepChanged({
    required super.currentStep,
    required super.isSameAddress,
    required super.formData,
  });
}

class ComplaintFormLoading extends ComplaintFormState {
  const ComplaintFormLoading({
    required super.currentStep,
    required super.isSameAddress,
    required super.formData,
  }) : super(isLoading: true);
}

class ComplaintFormSubmitted extends ComplaintFormState {
  final String message;

  const ComplaintFormSubmitted({
    required super.currentStep,
    required super.isSameAddress,
    required super.formData,
    required this.message,
  });

  @override
  List<Object?> get props => [...super.props, message];
}

class ComplaintFormError extends ComplaintFormState {
  final String error;

  const ComplaintFormError({
    required super.currentStep,
    required super.isSameAddress,
    required super.formData,
    required this.error,
  });

  @override
  List<Object?> get props => [...super.props, error];
}