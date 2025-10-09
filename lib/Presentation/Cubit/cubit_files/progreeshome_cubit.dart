import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/progressHome_state.dart';


class ServiceProgressCubit extends Cubit<ServiceProgressState> {
  ServiceProgressCubit() : super(ServiceProgressState.initial());

  void initializeService(String serviceName, int totalSteps) {
    final updatedProgress = Map<String, double>.from(state.servicesProgress);
    final updatedCurrentStep = Map<String, int>.from(state.servicesCurrentStep);
    final updatedTotalSteps = Map<String, int>.from(state.servicesTotalSteps);

    // Only initialize if not already present
    if (!updatedProgress.containsKey(serviceName)) {
      updatedProgress[serviceName] = 0.0;
      updatedCurrentStep[serviceName] = 0;
      updatedTotalSteps[serviceName] = totalSteps;
    }

    emit(state.copyWith(
      servicesProgress: updatedProgress,
      servicesCurrentStep: updatedCurrentStep,
      servicesTotalSteps: updatedTotalSteps,
    ));
  }

  void updateServiceProgress(String serviceName, int currentStep, int totalSteps) {
    final updatedProgress = Map<String, double>.from(state.servicesProgress);
    final updatedCurrentStep = Map<String, int>.from(state.servicesCurrentStep);
    final updatedTotalSteps = Map<String, int>.from(state.servicesTotalSteps);

    // Calculate progress (0.0 to 1.0)
    double progress = totalSteps > 0 ? currentStep / totalSteps : 0.0;
    progress = progress.clamp(0.0, 1.0);

    updatedProgress[serviceName] = progress;
    updatedCurrentStep[serviceName] = currentStep;
    updatedTotalSteps[serviceName] = totalSteps;

    emit(state.copyWith(
      servicesProgress: updatedProgress,
      servicesCurrentStep: updatedCurrentStep,
      servicesTotalSteps: updatedTotalSteps,
    ));
  }

  void completeService(String serviceName) {
    final totalSteps = state.servicesTotalSteps[serviceName] ?? 1;
    updateServiceProgress(serviceName, totalSteps, totalSteps);
  }

  void resetServiceProgress(String serviceName) {
    final updatedProgress = Map<String, double>.from(state.servicesProgress);
    final updatedCurrentStep = Map<String, int>.from(state.servicesCurrentStep);

    updatedProgress[serviceName] = 0.0;
    updatedCurrentStep[serviceName] = 0;

    emit(state.copyWith(
      servicesProgress: updatedProgress,
      servicesCurrentStep: updatedCurrentStep,
    ));
  }

  double getServiceProgress(String serviceName) {
    return state.servicesProgress[serviceName] ?? 0.0;
  }

  int getServiceCurrentStep(String serviceName) {
    return state.servicesCurrentStep[serviceName] ?? 0;
  }
}