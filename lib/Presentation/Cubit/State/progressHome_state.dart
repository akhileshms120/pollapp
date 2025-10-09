import 'package:equatable/equatable.dart';

class ServiceProgressState extends Equatable {
  final Map<String, double> servicesProgress;
  final Map<String, int> servicesCurrentStep;
  final Map<String, int> servicesTotalSteps;

  const ServiceProgressState({
    required this.servicesProgress,
    required this.servicesCurrentStep,
    required this.servicesTotalSteps,
  });

  factory ServiceProgressState.initial() {
    return const ServiceProgressState(
      servicesProgress: {},
      servicesCurrentStep: {},
      servicesTotalSteps: {},
    );
  }

  ServiceProgressState copyWith({
    Map<String, double>? servicesProgress,
    Map<String, int>? servicesCurrentStep,
    Map<String, int>? servicesTotalSteps,
  }) {
    return ServiceProgressState(
      servicesProgress: servicesProgress ?? this.servicesProgress,
      servicesCurrentStep: servicesCurrentStep ?? this.servicesCurrentStep,
      servicesTotalSteps: servicesTotalSteps ?? this.servicesTotalSteps,
    );
  }

  @override
  List<Object?> get props => [servicesProgress, servicesCurrentStep, servicesTotalSteps];
}