import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Core/routes/navigation.dart';
import 'package:pollapp/Domian/Entity/customScreenModel.dart';
import 'package:pollapp/Presentation/Cubit/State/bottomNavState.dart';
import 'package:pollapp/Presentation/Cubit/State/recentlyUsed_state.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/bottonnav_cubit.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/recentlyUser_cubit.dart';
import 'package:pollapp/Presentation/Singleton/recently_used_singleton.dart';
import 'package:pollapp/Presentation/Widgets/custom_appBar.dart';
import 'package:pollapp/Presentation/Widgets/custombottomnavbar.dart';
import 'package:pollapp/Presentation/Widgets/emergencyContat_corsel.dart';
import 'package:pollapp/Presentation/Widgets/howtouse_widget.dart';
import 'package:pollapp/Presentation/Widgets/location_corsel.dart';
import 'package:pollapp/Presentation/Widgets/newCard.dart';
import 'package:pollapp/Presentation/Widgets/pollappBottomSheet.dart';
import 'package:pollapp/Presentation/Widgets/progressicon.dart';
import 'package:pollapp/Presentation/Widgets/serviceIcon_widget.dart';
import 'package:pollapp/Presentation/Widgets/shareAppCard_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecentlyUsedCubit>.value(
          value: RecentlyUsedSingleton().cubit,
        ),
       // BlocProvider(create: (context) => RecentlyUsedCubit()),
        BlocProvider(create: (context) => BottomNavCubit()),
      ],
      child: HomeScreenContent(),
    );
  }
}

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
            const SizedBox(height: 16),
            InfoCardsCarousel(),
            const SizedBox(height: 16),
            SharePolAppCard(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            return CustomBottomNavigationBar(
              selectedIndex: state.selectedIndex,
              cubit: context.read<BottomNavCubit>(),
            );
          },
        ),
      ),
    );
  }

  void _showPolBloodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const PolBloodBottomSheetContent();
      },
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
        final bottomNavCubit = context.read<BottomNavCubit>();
        bottomNavCubit.selectTab(index);

        if (index == 1) {
          Get.toNamed(RoutesName.servicesScreen, arguments: bottomNavCubit);
        } else if (index == 2) {
        } else if (index == 4) {}
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

  void onServicePressed({
    required BuildContext context,
    required String serviceName,
  }) {
    BlocProvider.of<RecentlyUsedCubit>(context).markAsUsed(serviceName);
  }

  Widget _buildServicesGrid({required BuildContext context}) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.85,
      children: [
        ProgressCircleItem(
          title: AppConstants.certifcationofNonInvolvment,
          progress: 0.2,
          onPressed: () {
            onServicePressed(
              context: context,
              serviceName: AppConstants.certifcationofNonInvolvment,
            );
            Get.toNamed(
              RoutesName.commonScreen,
              arguments: Customscreenmodel(
                appBarTitle: AppConstants.completeReistration,
           
              ),
            );
          },
        ),
        ProgressCircleItem(
          title: AppConstants.completeReistration,
          progress: 0.2,
          onPressed: () {
            onServicePressed(
              context: context,
              serviceName: AppConstants.completeReistration,
            );
            Get.toNamed(
              RoutesName.commonScreen,
              arguments: Customscreenmodel(
                appBarTitle: AppConstants.completeReistration,
          
              ),
            );
          },
        ),
        ProgressCircleItem(
          title: AppConstants.accidentGD,
          progress: 0,
          onPressed: () {
            onServicePressed(
              context: context,
              serviceName: AppConstants.accidentGD,
            );
            Get.toNamed(
              RoutesName.commonScreen,
              arguments: Customscreenmodel(
                appBarTitle: AppConstants.accidentGD,
            
              ),
            );
          },
        ),
        ProgressCircleItem(
          title: 'Pol-Blood',
          progress: 0,
          onPressed: () {
            onServicePressed(
              context: context,
              serviceName: 'Pol-Blood',
            );
           _showPolBloodBottomSheet(context);
          },
        ),
        ProgressCircleItem(
          title: AppConstants.firdownload,
          progress: 0,
          onPressed: () {
            onServicePressed(
              context: context,
              serviceName: AppConstants.firdownload,
            );
            Get.toNamed(
              RoutesName.commonScreen,
              arguments: Customscreenmodel(
                appBarTitle: AppConstants.firdownload,
             
              ),
            );
          },
        ),
      NavigationCircleItem(onPressed:()=>Get.toNamed(RoutesName.servicesScreen) ,title: 'View All',showArrow: true,)
      ],
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
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => NavigationService().navigateToService(serviceName:state.usedServices[index]),
                child: ServiceIconWidget(serviceId: state.topServices[index]));
            },
          ),
        );
      },
    );
  }
 
}





