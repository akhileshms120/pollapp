import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/bottonnav_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final BottomNavCubit cubit;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            icon: Icons.home,
            label: 'Home',
            selectedColor: Colors.grey.shade700,
            isSelected: selectedIndex == 0,
          ),
          _buildNavItem(
            context: context,
            index: 1,
            icon: Icons.grid_view,
            label: 'Service',
            selectedColor: Colors.grey.shade700,
            isSelected: selectedIndex == 1,
          ),
          _buildSOSButton(context),
          _buildNavItem(
            context: context,
            index: 3,
            icon: Icons.contacts,
            label: 'Contact',
            selectedColor: Colors.grey.shade700,
            isSelected: selectedIndex == 3,
          ),
          _buildNavItem(
            context: context,
            index: 4,
            icon: Icons.person,
            label: 'Profile',
            selectedColor: Colors.grey.shade700,
            isSelected: selectedIndex == 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color selectedColor,
  }) {
    return GestureDetector(
      onTap: () {
        cubit.selectTab(index);

        switch (index) {
          case 0:
            Get.toNamed(RoutesName.homeScreen,arguments: index);
            break;
          case 1:
            Get.toNamed(RoutesName.servicesScreen,arguments: index);
            break;
          case 3:
            Get.toNamed(RoutesName.contactScreen,arguments: index);
            break;
          case 4:
            Get.toNamed(RoutesName.profileScreen,arguments: index);
            break;
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? selectedColor : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? selectedColor : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSOSButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.triggerSOS();
        _showSOSDialog(context);
      },
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            SizedBox(width: 8),
            Text('SOS Emergency'),
          ],
        ),
        content: const Text(
          'Are you sure you want to trigger an emergency alert?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Emergency alert sent!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
