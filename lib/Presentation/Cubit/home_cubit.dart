import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Domian/Entity/service_entity.dart';
import 'package:pollapp/Presentation/Cubit/homescreen_state.dart';


class HomeCubit extends Cubit<HomescreenState> {
  HomeCubit() : super(HomeLoaded());

  void loadHome() {
    // Initialize with some default recently used services
    final initialRecentlyUsed = [
      ServiceEntity(
        id: '1',
        title: 'Complaint\nRegistration',
        iconName: 'mail_outline', route: '',
      ),
      ServiceEntity(
        id: '2',
        title: 'Certificate\nof Non-Inv...',
        iconName: 'verified_outlined', route: '',
      ),
      ServiceEntity(
        id: '6',
        title: 'Nearest\nPolice ...',
        iconName: 'location_on_outlined', route: '',
      ),
    ];
    
    emit(HomeLoaded(recentlyUserServices: initialRecentlyUsed));
  }

  void updateEmergencyIndex(int index) {
    final state = this.state;
    if (state is HomeLoaded) {
      emit(state.copyWith(currentEmergencyIndex: index));
    }
  }

  void updateBottomNavIndex(int index) {
    final state = this.state;
    if (state is HomeLoaded) {
      emit(state.copyWith(selectedBottomNavIndex: index));
    }
  }

  void addToRecentlyUsed(ServiceEntity service) {
    final state = this.state;
    if (state is HomeLoaded) {
      List<ServiceEntity> updatedRecentlyUsed = List.from(state.recentlyUserServices);
      
      // Remove if already exists to avoid duplicates
      updatedRecentlyUsed.removeWhere((s) => s.id == service.id);
      
      // Add to the beginning of the list
      updatedRecentlyUsed.insert(0, service);
      
      // Keep only the last 6 items
      if (updatedRecentlyUsed.length > 6) {
        updatedRecentlyUsed = updatedRecentlyUsed.take(6).toList();
      }
      
      emit(state.copyWith(recentlyUsedServices: updatedRecentlyUsed));
    }
  }
}
