import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicesHomePage extends StatefulWidget {
  const ServicesHomePage({Key? key}) : super(key: key);

  @override
  State<ServicesHomePage> createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  int _selectedIndex = 1;

  final List<ServiceItem> thunaServices = [
    ServiceItem(
      icon: Icons.description_outlined,
      title: 'Complaint Registration',
      color: Color(0xFF2196F3),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.workspace_premium_outlined,
      title: 'Certificate of Non-Inv...',
      color: Color(0xFF9C27B0),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.campaign_outlined,
      title: 'Mike Sanction Registration',
      color: Color(0xFFFF9800),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.download_outlined,
      title: 'FIR Download',
      color: Color(0xFF4CAF50),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.directions_car_outlined,
      title: 'Accident GD',
      color: Color(0xFFF44336),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.help_outline,
      title: 'Lost Property',
      color: Color(0xFFFFEB3B),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.credit_card_outlined,
      title: 'Payment History',
      color: Color(0xFF3F51B5),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.calendar_today_outlined,
      title: 'Event/Performance',
      color: Color(0xFFE91E63),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.warning_outlined,
      title: 'Grievances Redressal',
      color: Color(0xFFF44336),
      isNew: true,
    ),
    ServiceItem(
      icon: Icons.person_off_outlined,
      title: 'Arrest Search',
      color: Color(0xFF607D8B),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.message_outlined,
      title: 'Feedback',
      color: Color(0xFF009688),
      isNew: true,
    ),
  ];

  final List<ServiceItem> polBloodServices = [
    ServiceItem(
      icon: Icons.water_drop_outlined,
      title: 'Blood Donation',
      color: Color(0xFFDC2626),
      isNew: false,
    ),
    ServiceItem(
      icon: Icons.shield_outlined,
      title: 'Blood Request',
      color: Color(0xFF2563EB),
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'SERVICES',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.lock_outline, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: [
          SizedBox(height: 8),
          // Thuna Services
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Thuna Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          _buildServiceGrid(thunaServices),
          SizedBox(height: 16),
          
          // Pol-Blood Services
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Pol-Blood Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          _buildServiceGrid(polBloodServices),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildServiceGrid(List<ServiceItem> services) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(services[index]);
        },
      ),
    );
  }

  Widget _buildServiceCard(ServiceItem service) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.0),
      duration: Duration(milliseconds: 200),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            onTapDown: (_) {
              setState(() {});
            },
            onTapUp: (_) {
              setState(() {});
            },
            onTapCancel: () {
              setState(() {});
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: service.color.withOpacity(0.1),
            highlightColor: service.color.withOpacity(0.05),
            child: AnimatedScale(
              scale: 1.0,
              duration: Duration(milliseconds: 100),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: service.color,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: service.color.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            service.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Spacer(),
                        Text(
                          service.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (service.isNew)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF5252),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.grey[300],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_outlined, 'Home', 0),
                  _buildNavItem(Icons.grid_view_rounded, 'Services', 1),
                  SizedBox(width: 80), // Space for SOS button
                  _buildNavItem(Icons.people_outline, 'Contacts', 2),
                  _buildNavItem(Icons.person_outline, 'More', 3),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -10,
                child: Center(
                  child: _buildSOSButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFF2196F3) : Color(0xFFBDBDBD),
              size: 26,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Color(0xFF2196F3) : Color(0xFFBDBDBD),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton() {
    return GestureDetector(
      onTap: () {
        // Handle SOS tap
      },
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF5252), Color(0xFFE53935)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFF5252).withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
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
}

class ServiceItem {
  final IconData icon;
  final String title;
  final Color color;
  final bool isNew;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.isNew,
  });
}

