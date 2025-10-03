import 'package:pollapp/Domian/Entity/emergencyContact_entity.dart';
import 'package:pollapp/Domian/Repositories/service_repositories.dart';

class GetEmergencyContactsUseCase {
  final ServiceRepository repository;

  GetEmergencyContactsUseCase(this.repository);

  Future<List<EmergencyContactEntity>> call() async {
    return await repository.getEmergencyContacts();
  }
}