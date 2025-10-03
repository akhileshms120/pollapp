import 'package:pollapp/Domian/Entity/emergencyContact_entity.dart';
import 'package:pollapp/Domian/Entity/service_entity.dart';

class StaticData {
  static List <ServiceEntity> getServices(){
    return [
    ServiceEntity(id: '1', title: 'Complaint\nRegistration', iconName: 'mail_outline', route:'complaint_screen'),
    ServiceEntity(
        id: '2',
        title: 'Certificate of\nNon-Involv...',
        iconName: 'verified_outlined',
        route: 'certificate_screen'
      ),
      ServiceEntity(
        id: '3',
        title: 'Accident GD',
        iconName: 'car_crash_outlined',
        route: 'accident_screen'
      ),
      ServiceEntity(
        id: '4',
        title: 'Pol-Blood',
        iconName: 'bloodtype_outlined',
        route: 'pollBlood_screen'
      ),
      ServiceEntity(
        id: '5',
        title: 'FIR\nDownload',
        iconName: 'download_outlined',
        route: 'fir_screen'
      ),
    ];
  }
  static List<EmergencyContactEntity> getEmergencyContacts() {
    return [
      EmergencyContactEntity(
        id: '1',
        title: 'Police Complaint Authority',
        number: '04712335939',
        colorHex: '#F44336',
      ),
      EmergencyContactEntity(
        id: '2',
        title: 'Emergency Police',
        number: '100',
        colorHex: '#2196F3',
      ),
      EmergencyContactEntity(
        id: '3',
        title: 'Fire Service',
        number: '101',
        colorHex: '#FF9800',
      ),
    ];
  }
}

