import 'package:pollapp/Domian/Entity/service_entity.dart';
import 'package:pollapp/Domian/Repositories/service_repositories.dart';

class GetRecentlyUsedServicesUseCase {
  final ServiceRepository repository;

  GetRecentlyUsedServicesUseCase(this.repository);

  Future<List<ServiceEntity>> call() async {
    return await repository.getRecentlyUsedServices();
  }
}