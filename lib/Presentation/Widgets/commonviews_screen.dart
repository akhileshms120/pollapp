import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/app_constants.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Domian/Entity/customScreenModel.dart';
import 'package:pollapp/Presentation/Views/firdownload_screen.dart';
import 'package:pollapp/Presentation/Widgets/arrestSearch_screen.dart';
import 'package:pollapp/Presentation/Widgets/filterindutWidget.dart';
import 'package:pollapp/Presentation/Widgets/grevanceReadresseal.dart';
import 'package:pollapp/Presentation/Widgets/sortwidget.dart';
import 'package:pollapp/Presentation/Widgets/tracktrip_widget.dart';

class CommonScreen extends StatefulWidget {
  CommonScreen({Key? key}) : super(key: key);
  bool activate = false;

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  String _pressedTab = "";
  final Customscreenmodel customscreenmodel = Get.arguments;
  String _selectedTab = 'Submitted';

  // Returns ONLY the tab/filter UI (not the main content)
  Widget _commonScreenTabUI(String pageName) {
    switch (pageName) {
      case 'Grievance About Services':
      case 'Accident GD Requests':
      case 'Lost Property Requests':
      case 'Locked House Requests':
      case AppConstants.singlewoman:
      case AppConstants.arrestSearch:
      case AppConstants.trackmytrip:
      case AppConstants.firdownload:
      case AppConstants.seniorCitizen:
      case AppConstants.reportOffence:
      case AppConstants.reportAbandoned:
      case 'Cyber Report List':
        // For form screens, show nothing in the tab area
        return const SizedBox.shrink();

      case AppConstants.paymentHistory:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TonalOption(
                icon: Icons.sort_rounded,
                title: 'Sort by',
                subtitle: 'Request Date',
                onTap: () {
                  setState(() {
                    widget.activate == true
                        ? widget.activate = false
                        : widget.activate = true;
                  });
                },
                isActive: widget.activate,
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: TonalOption(
                icon: Icons.filter_list_rounded,
                title: 'Filter by',
                subtitle: 'Not applied',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return const FilterDataBottomSheet();
                    },
                  );
                },
              ),
            ),
          ],
        );
      default:
        return Row(children: [_buildTab('Submitted'), _buildTab('Draft')]);
    }
  }

  // Returns the main content area
  Widget _commonScreenContentUI(String pageName) {
    switch (pageName) {
      case 'Arrest Search':
        return ArrestSearchScreen();
      case 'Grievance About Services':
        return GrievanceFormScreen();
      case 'Track My Trip':
        return TrackMyTripScreen();
      case AppConstants.firdownload:
        return FirDownloadScreen();
      // case 'Accident GD Requests':
      // case 'Lost Property Requests':
      //   return SizedBox();
      default:
        // For list screens, show empty state in a card
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: _buildEmptyState(),
          ),
        );
    }
  }

  Widget _buildTab(String title) {
    final bool isSelected = _selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressedTab = title),
        onTapUp: (_) {
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              _pressedTab = '';
              _selectedTab = title;
            });
          });
        },
        onTapCancel: () => setState(() => _pressedTab = ''),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 46,
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(_pressedTab == title ? 0.96 : 1.0),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFFFFFFFF), Color(0xFFF6F7FB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4CA1AF)
                  : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFF4CA1AF).withOpacity(0.35)
                    : Colors.grey.withOpacity(0.15),
                blurRadius: isSelected ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 15,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF4CA1AF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.assignment_turned_in_rounded,
              size: 45,
              color: Color(0xFF4CA1AF),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            _selectedTab == 'Submitted'
                ? 'No submitted requests found'
                : 'No draft requests found',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewRequestButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4CA1AF).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.2),
          onTap: () {
            Get.toNamed(
              RoutesName.complaintFormWidgetScreen,
              arguments: customscreenmodel.appBarTitle,
            );
          },
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: Colors.white, size: 22),
                SizedBox(width: 8),
                Text(
                  'New Request',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Check if the current screen is a form that needs scrolling
  bool _isFormScreen() {
    return customscreenmodel.appBarTitle == 'Grievance About Services' ||
        customscreenmodel.appBarTitle == AppConstants.arrestSearch ||
        customscreenmodel.appBarTitle == AppConstants.trackmytrip ||
        customscreenmodel.appBarTitle == AppConstants.firdownload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF6F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          customscreenmodel.appBarTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.info_outline_rounded,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: _isFormScreen()
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: _commonScreenTabUI(customscreenmodel.appBarTitle),
                ),
                // Main form content
                SingleChildScrollView(
                  child: _commonScreenContentUI(customscreenmodel.appBarTitle),
                ),
                // Spacing for bottom button
                const SizedBox(height: 100),
              ],
            )
          : Column(
              children: [
                // Tabs/filters
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: _commonScreenTabUI(customscreenmodel.appBarTitle),
                  ),
                ),
                // Content (empty state card)
                _commonScreenContentUI(customscreenmodel.appBarTitle),
              ],
            ),
      bottomNavigationBar: _isFormScreen()
          ? SizedBox()
          : _buildNewRequestButton(),
    );
  }
}
