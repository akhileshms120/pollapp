// lib/Core/Services/navigation_service.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Domian/Entity/customScreenModel.dart';

import 'package:pollapp/Presentation/Singleton/recently_used_singleton.dart';


class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  // Navigation configuration map
  static final Map<String, NavigationConfig> _navigationMap = {
    AppConstants.completeReistration: NavigationConfig(
      title: 'Complaint Requests',
      
    ),
    AppConstants.certifcationofNonInvolvment: NavigationConfig(
      title: 'NIOC Requests',
      
    ),
    AppConstants.mikesanction: NavigationConfig(
      title: 'Mike List',
      
    ),
    AppConstants.firdownload: NavigationConfig(
      title: AppConstants.firdownload,
      
    ),
    AppConstants.accidentGD: NavigationConfig(
      title: 'Accident GD Requests',
      
    ),
    AppConstants.lostProperty: NavigationConfig(
      title: 'Lost Property Requests',
      
    ),
    AppConstants.paymentHistory: NavigationConfig(
      useOriginalTitle: true,
      
    ),
    AppConstants.eventPerformance: NavigationConfig(
      title: AppConstants.eventPerformance,
      
    ),
    AppConstants.grevanceReadresseal: NavigationConfig(
      title: 'Grievance About Services',
      
    ),
    AppConstants.arrestSearch: NavigationConfig(
      title: AppConstants.arrestSearch,
      
    ),
    AppConstants.lockedHouse: NavigationConfig(
      title: 'Locked House Requests',
      
    ),
    AppConstants.trackmytrip: NavigationConfig(
      useOriginalTitle: true,
      
    ),
    AppConstants.seniorCitizen: NavigationConfig(
      useOriginalTitle: true,
      
    ),
    AppConstants.singlewoman: NavigationConfig(
      useOriginalTitle: true,
      
    ),
    AppConstants.reportOffence: NavigationConfig(
      useOriginalTitle: true,
      
    ),
    AppConstants.reportAbandoned: NavigationConfig(
      title: 'Abandoned Report List',
      
    ),
    AppConstants.reportCyberFraud: NavigationConfig(
      title: 'Cyber Report List',
      
    ),
  };

  // Main navigation method
  void navigateToService({
    required String serviceName,
    BuildContext? context,
  }) {
    // Get navigation config
    final config = _navigationMap[serviceName] ?? NavigationConfig(
      useOriginalTitle: true,
      
    );

    // Determine title
    final titleToSend = config.useOriginalTitle 
        ? serviceName 
        : (config.title ?? serviceName);

    // Navigate
    Get.toNamed(
      RoutesName.commonScreen,
      arguments: Customscreenmodel(
        appBarTitle: titleToSend,

      ),
    );

    // Mark as recently used
    _markAsRecentlyUsed(serviceName, context);
  }

  // Private method to handle recently used
  void _markAsRecentlyUsed(String serviceName, BuildContext? context) {
    try {
      // Option 1: Using singleton
      RecentlyUsedSingleton().cubit.markAsUsed(serviceName);
      
      // Option 2: Using context if available
      // if (context != null) {
      //   context.read<RecentlyUsedCubit>().markAsUsed(serviceName);
      // }
    } catch (e) {
      print('Error marking service as recently used: $e');
    }
  }
}

// Configuration class
class NavigationConfig {
  final String? title;

  final bool useOriginalTitle;

  NavigationConfig({
    this.title,

    this.useOriginalTitle = false,
  });
}