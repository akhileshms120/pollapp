
import 'package:pollapp/Domian/Entity/emergencyContact_entity.dart';
import 'package:pollapp/Domian/Entity/service_entity.dart';

abstract class ServiceRepository {
  Future<List<ServiceEntity>> getServices();
  Future<List<ServiceEntity>> getRecentlyUsedServices();
  Future<List<EmergencyContactEntity>> getEmergencyContacts();
  Future<void> addToRecentlyUsed(ServiceEntity service);
}