import 'package:pollapp/Domian/Entity/service_entity.dart';

abstract class HomescreenState {}

class HomeLoaded extends HomescreenState{
  final int currentEmergencyIndex;
  final int selectedBottonNavIndex;
  final List<ServiceEntity> recentlyUserServices;
  HomeLoaded({this.recentlyUserServices=const[],  this.currentEmergencyIndex=0,  this.selectedBottonNavIndex=0});
   HomeLoaded copyWith({
    int? currentEmergencyIndex,
    int? selectedBottomNavIndex,
    List<ServiceEntity>? recentlyUsedServices,
  }) {
    return HomeLoaded(
      currentEmergencyIndex: currentEmergencyIndex ?? this.currentEmergencyIndex,
      selectedBottonNavIndex: selectedBottomNavIndex ?? this.selectedBottonNavIndex,
      recentlyUserServices: recentlyUsedServices ?? this.recentlyUserServices,
    );
}}