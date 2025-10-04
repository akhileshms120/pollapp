import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/recentlyUsed_state.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/recentlyUser_cubit.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';
import 'package:pollapp/Presentation/Widgets/emergencyContat_corsel.dart';
import 'package:pollapp/Presentation/Widgets/howtouse_widget.dart';
import 'package:pollapp/Presentation/Widgets/location_corsel.dart';
import 'package:pollapp/Presentation/Widgets/newCard.dart';
import 'package:pollapp/Presentation/Widgets/shareAppCard_widget.dart';

// Wrapper that provides the cubit
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentlyUsedCubit(),
      child: HomeScreenContent(),
    );
  }
}

// Actual home screen content
class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeScreenAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [   
            const LocationCard(),
            const Text(
              'Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildServicesGrid(context: context),
            const SizedBox(height: 32),
            const Text(
              'Recently Used',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRecentlyUsedRow(),
            const SizedBox(height: 32),
            const Text(
              'Emergency Number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
               const EmergencyContactsCarousel(),
                const SizedBox(height: 16),
                   const Text(
              'Latest News',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            
            ),
             const SizedBox(height: 16),
            LatestNewsCarousel(),
                  const SizedBox(height: 10),
            Center(child: Text("View All")),
            const SizedBox(height: 16),
            
             const Text(
              'How to use',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            
            ),
            const SizedBox(height: 16,),
            InfoCardsCarousel(),
             const SizedBox(height: 16,),
            SharePolAppCard()


          ],
        ),
      ),
    bottomNavigationBar:Container(
  margin: const EdgeInsets.all(16),
  height: 70,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _buildNavItem(Icons.home_outlined, 'Home', true),
      _buildNavItem(Icons.chat_bubble_outline, 'Service', false),
      _buildNavItem(Icons.shield_outlined, 'Contact', false),
      _buildNavItem(Icons.person_outline, 'Profile', false),
    ],
  ),
),
    );
  }
Widget _buildNavItem(IconData icon, String label, bool isSelected) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.grey,
        size: 24,
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    ],
  );
}
  void onServicePressed({required BuildContext context, required String serviceName}) {
    BlocProvider.of<RecentlyUsedCubit>(context).markAsUsed(serviceName);
  }

  Widget _buildServicesGrid({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          _ServiceItem(
            icon: Icons.assignment,
            label: 'Complaint and Registration',
            onPressed: () => onServicePressed(
              context: context,
              serviceName: 'Complaint and Registration',
            ),
          ),
          _ServiceItem(
            icon: Icons.policy,
            label: 'Certification of Non-involvment',
            onPressed: () => onServicePressed(
              context: context,
              serviceName: 'Certification of Non-involvment',
            ),
          ),
          _ServiceItem(
            icon: Icons.assignment_late,
            label: 'Accident GD',
            onPressed: () => onServicePressed(
              context: context,
              serviceName: 'Accident GD',
            ),
          ),
          _ServiceItem(
            icon: Icons.bloodtype_outlined,
            label: 'Pol-Blood',
            onPressed: () => onServicePressed(
              context: context,
              serviceName: 'Pol-Blood',
            ),
          ),
          _ServiceItem(
            icon: Icons.download_for_offline,
            label: 'FIR Download',
            onPressed: () => onServicePressed(
              context: context,
              serviceName: 'FIR Download',
            ),
          ),
          _ServiceItem(
            icon: Icons.arrow_right_alt,
            label: 'View All',
            onPressed: (){},
            // onPressed: () => onServicePressed(
            //   context: context,
            //   serviceName: 'View All',
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyUsedRow() {
    return BlocBuilder<RecentlyUsedCubit, RecentlyUsedState>(
      builder: (context, state) {
        if (state.topServices.isEmpty) {
          return const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'No recently used services',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.topServices.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return ServiceIconWidget(serviceId: state.topServices[index]);
            },
          ),
        );
      },
    );
  }
  



}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ServiceItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          shape: const CircleBorder(),
          elevation: 4,
          shadowColor: Colors.black26,
          child: IconButton.filledTonal(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 4),
        CustomWidget.customTextWidget(
          text: label,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ServiceIconWidget extends StatelessWidget {
  final String serviceId;

  const ServiceIconWidget({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  IconData _getIconForService(String serviceName) {
    switch (serviceName) {
      case 'Complaint and Registration':
        return Icons.assignment;
      case 'Certification of Non-involvment':
        return Icons.policy;
      case 'Accident GD':
        return Icons.assignment_late;
      case 'Pol-Blood':
        return Icons.bloodtype_outlined;
      case 'FIR Download':
        return Icons.download_for_offline;
      case 'View All':
        return Icons.arrow_right_alt;
      default:
        return Icons.apps;
    }
  }

  Color _getBackgroundColor(String serviceName) {
    switch (serviceName) {
      case 'Complaint and Registration':
        return const Color(0xFFE0F7FA);
      case 'Certification of Non-involvment':
        return const Color(0xFFFCE4EC);
      case 'Accident GD':
        return const Color(0xFFFFF9C4);
      case 'Pol-Blood':
        return const Color(0xFFFFCDD2);
      case 'FIR Download':
        return const Color(0xFFE1BEE7);
      // case 'View All':
      //   return const Color(0xFFDCEDC8);
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getIconColor(String serviceName) {
    switch (serviceName) {
      case 'Complaint and Registration':
        return Colors.teal.shade700;
      case 'Certification of Non-involvment':
        return Colors.pink.shade700;
      case 'Accident GD':
        return Colors.amber.shade700;
      case 'Pol-Blood':
        return Colors.red.shade700;
      case 'FIR Download':
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
      child: Icon(
        _getIconForService(serviceId),
        color: _getIconColor(serviceId),
        size: 28,
      ),
    );
  }
}