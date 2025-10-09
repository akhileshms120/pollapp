import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';


class ServiceIconWidget extends StatelessWidget {
  final String serviceId;

  const ServiceIconWidget({Key? key, required this.serviceId})
    : super(key: key);

  String _getIconForService(String serviceName) {
    switch (serviceName) {
      case AppConstants.completeReistration:
        return completeReistration;
       case AppConstants.certifcationofNonInvolvment:
         return certifcationofNonInvolvment;
       case AppConstants.accidentGD:
         return accidentGD;
       case 'Pol-Blood':
        return polblood;
       case AppConstants.firdownload:
        return firDownload;
      // case 'View All':
      //   return Icons.arrow_right_alt;
       default:
         return "";
    }
  }

  Color _getBackgroundColor(String serviceName) {
    switch (serviceName) {
      case AppConstants.completeReistration:
        return const Color(0xFFE0F7FA);
      case AppConstants.certifcationofNonInvolvment:
        return const Color(0xFFFCE4EC);
      case AppConstants.accidentGD:
        return const Color(0xFFFFF9C4);
      case 'Pol-Blood':
        return const Color(0xFFFFCDD2);
      case AppConstants.firdownload:
        return const Color(0xFFE1BEE7);
      // case 'View All':
      //   return const Color(0xFFDCEDC8);
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getIconColor(String serviceName) {
    switch (serviceName) {
      case AppConstants.completeReistration:
        return Colors.teal.shade700;
      case AppConstants.certifcationofNonInvolvment:
        return Colors.pink.shade700;
      case AppConstants.accidentGD:
        return Colors.amber.shade700;
      case 'Pol-Blood':
        return Colors.red.shade700;
      case AppConstants.firdownload:
        return Colors.purple.shade700;
      // case 'View All':
      //   return Colors.green.shade700;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: _getBackgroundColor(serviceId),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child:Image.asset(
        _getIconForService(serviceId),
        color: _getIconColor(serviceId),
        colorBlendMode: BlendMode.srcIn,
        width: 5,
        height: 5,
      ),
    );
  }
}
