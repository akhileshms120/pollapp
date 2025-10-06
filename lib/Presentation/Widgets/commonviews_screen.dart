import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';

class CommonScreen extends StatefulWidget {
 

   CommonScreen({Key? key,}) : super(key: key);
   

  @override
  State<CommonScreen> createState() => _CommonScreenState();
  
}

class _CommonScreenState extends State<CommonScreen> {
    final String appBarTitle = Get.arguments ?? 'Default Title';

  String _selectedTab = 'Submitted';
  
 
  Widget _buildTab(String title) {
    final bool isSelected = _selectedTab == title;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFFFFFFFF), Color(0xFFF2F3F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF4CA1AF).withOpacity(0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
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

  // --- Build modern "New Request" button ---
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
          onTap: () {Get.toNamed(RoutesName.complaintFormWidgetScreen,arguments: appBarTitle);},
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          appBarTitle,
          //'Complaint Requests',
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
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.info_outline_rounded, color: Colors.black87),
              onPressed: () {},
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // --- Tabs ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFE9EDF0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _buildTab('Submitted'),
                  _buildTab('Draft'),
                ],
              ),
            ),
          ),

          // --- Card Section ---
          Expanded(
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
          ),
        ],
      ),

     
      bottomNavigationBar: _buildNewRequestButton(),
    );
  }
}
