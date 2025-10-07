import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Presentation/Cubit/State/bottomNavState.dart';
import 'package:pollapp/Presentation/Cubit/State/servicestate.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/bottonnav_cubit.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/servicescreen_cubit.dart';
import 'package:pollapp/Presentation/Widgets/custombottomnavbar.dart';

class ServiceScreen extends StatefulWidget {
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final _newIndex = Get.arguments;

  late final BottomNavCubit bottomNavCubit;

  @override
  void initState() {
    super.initState();
    bottomNavCubit = BottomNavCubit();
    if (_newIndex != null) {
      bottomNavCubit.selectTab(_newIndex!);
    }
  }

  @override
  void dispose() {
    bottomNavCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>.value(value: bottomNavCubit),
        BlocProvider(create: (context) => ServicesCubit()),
      ],
      child: ServicesHomePage(),
    );
  }
}

class ServicesHomePage extends StatelessWidget {
  final List<ServiceItem> thunaServices = [
    ServiceItem(
      image: "assets/images/new/services/complaint.png",
      title: 'Complaint Registration',
      color: Color(0xFF2196F3),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/pcc.png",

      title: 'Certificate of Non-Inv...',
      color: Color(0xFF9C27B0),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/mike.png",

      title: 'Mike Sanction Registration',
      color: Color(0xFFFF9800),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/fir.png",

      title: 'FIR Download',
      color: Color(0xFF4CAF50),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/accident.png",

      title: 'Accident GD',
      color: Color(0xFFF44336),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/lost-property.png",

      title: 'Lost Property',
      color: Color(0xFFFFEB3B),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/payment.png",

      title: 'Payment History',
      color: Color(0xFF3F51B5),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/event.png",

      title: 'Event/Performance',
      color: Color(0xFFE91E63),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/grievance-report.png",

      title: 'Grievances Redressal',
      color: Color(0xFFF44336),
      isNew: true,
    ),
    ServiceItem(
      image: "assets/images/new/services/arrest-search.png",

      title: 'Arrest Search',
      color: Color(0xFF607D8B),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/feedback.png",

      title: 'Feedback',
      color: Color(0xFF009688),
      isNew: true,
    ),
  ];

  final List<ServiceItem> polBloodServices = [
    ServiceItem(
      image: "assets/images/new/services/blood-donate.png",

      title: 'Blood Donation',
      color: Color(0xFFDC2626),
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/blood-request.png",

      title: 'Blood Request',
      color: Color(0xFF2563EB),
      isNew: false,
    ),
  ];
  final List<ServiceItem> citizenSafteyServices = [
    ServiceItem(
      image: "assets/images/new/services/track-trip.png",
      title: 'Track My Trip',
      color: Color(0xFF00BCD4), // Cyan
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/locked-house.png",
      title: 'Locked House Information',
      color: Color(0xFF8E24AA), // Purple
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/senior-citizen.png",
      title: 'Senior Citizen Information',
      color: Color(0xFFFF6F00), // Deep Orange
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/single-woman.png",
      title: 'Single Woman',
      color: Color(0xFFD81B60), // Pink
      isNew: false,
    ),
  ];

  final List<ServiceItem> reportToUs = [
    ServiceItem(
      image: "assets/images/new/services/report-offence.png",
      title: 'Report An Offence',
      color: Color(0xFFE53935), // Red
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/abandoned.png",
      title: 'Report Abandoned List',
      color: Color(0xFF43A047), // Green
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/spam-report.png",
      title: 'Report A Cyber Fraud',
      color: Color(0xFFFF7043), // Deep Orange
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/share-info.png",
      title: 'Share Information Anonymously',
      color: Color(0xFF5E35B1), // Deep Purple
      isNew: false,
    ),
  ];

  final List<ServiceItem> personalServices = [
    ServiceItem(
      image: "assets/images/new/services/appointment.png",
      title: 'Appointment With SHO',
      color: Color(0xFF00897B), // Teal
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/find-ps.png",
      title: 'Search Police Station',
      color: Color(0xFF1E88E5), // Blue
      isNew: false,
    ),
  ];

  final List<ServiceItem> informationServices = [
    ServiceItem(
      image: "assets/images/new/services/internet-tips.png",
      title: 'Internet Tips',
      color: Color(0xFF6D4C41), // Brown
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/cyber-security.png",
      title: 'Cyber Security Information',
      color: Color(0xFF26A69A), // Teal
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/tourist-guide.png",
      title: 'Tourist Guide',
      color: Color(0xFFAB47BC), // Purple
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/user-manual.png",
      title: 'User Manual',
      color: Color(0xFF42A5F5), // Light Blue
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/training.png",
      title: 'Awareness Classes',
      color: Color(0xFFFFA726), // Orange
      isNew: false,
    ),
  ];

  final List<ServiceItem> rateUs = [
    ServiceItem(
      image: "assets/images/new/services/rate-ps.png",
      title: 'Rate Police Station',
      color: Color(0xFFFDD835), // Yellow
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/rate-app.png",
      title: 'Rate Application',
      color: Color(0xFF66BB6A), // Light Green
      isNew: false,
    ),
  ];

  final List<ServiceItem> webLinks = [
    ServiceItem(
      image: "assets/images/new/services/social-media.png",
      title: 'Social Media',
      color: Color(0xFF29B6F6), // Light Blue
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/kerala-govt.png",
      title: 'Government of Kerala',
      color: Color(0xFF8D6E63), // Brown
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/kerala-police.png",
      title: 'Kerala Police',
      color: Color(0xFF5C6BC0), // Indigo
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/thuna.png",
      title: 'Citizen Services (THUNA)',
      color: Color(0xFF26C6DA), // Cyan
      isNew: false,
    ),
    ServiceItem(
      image: "assets/images/new/services/cyberdome.png",
      title: 'Cyber Dome',
      color: Color(0xFF7E57C2), // Deep Purple
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
      body: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, servicesState) {
          return ListView(
            padding: EdgeInsets.only(bottom: 100),
            children: [
              SizedBox(height: 8),
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
              _buildServiceGrid(context, thunaServices, servicesState, 0),
              SizedBox(height: 16),
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
              _buildServiceGrid(
                context,
                polBloodServices,
                servicesState,
                thunaServices.length,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Citizen Saftey Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildServiceGrid(
                context,
                citizenSafteyServices,
                servicesState,
                thunaServices.length + polBloodServices.length,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Report To Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildServiceGrid(
                context,
                reportToUs,
                servicesState,
                thunaServices.length +
                    polBloodServices.length +
                    citizenSafteyServices.length,
              ),

              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Personal Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildServiceGrid(
                context,
                personalServices,
                servicesState,
                thunaServices.length +
                    polBloodServices.length +
                    citizenSafteyServices.length +
                    reportToUs.length, // Fixed
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Information Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildServiceGrid(
                context,
                informationServices,
                servicesState,
                thunaServices.length +
                    polBloodServices.length +
                    citizenSafteyServices.length +
                    reportToUs.length +
                    personalServices.length,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Rate Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildServiceGrid(
                context,
                rateUs,
                servicesState,
                thunaServices.length +
                    polBloodServices.length +
                    citizenSafteyServices.length +
                    reportToUs.length +
                    personalServices.length +
                    informationServices.length,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Web Links',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildServiceGrid(
                context,
                webLinks,
                servicesState,
                thunaServices.length +
                    polBloodServices.length +
                    citizenSafteyServices.length +
                    reportToUs.length +
                    personalServices.length +
                    informationServices.length +
                    rateUs.length,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) => CustomBottomNavigationBar(
            selectedIndex: state.selectedIndex,
            cubit: context.read<BottomNavCubit>(),
          ),
          //_buildBottomNav(state, context),
        ),
      ),
    );
  }

  Widget _buildServiceGrid(
    BuildContext context,
    List<ServiceItem> services,
    ServicesState servicesState,
    int startIndex,
  ) {
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
          final globalIndex = startIndex + index;
          final isPressed = servicesState.pressedCardIndex == globalIndex;
          return _buildServiceCard(
            context,
            services[index],
            globalIndex,
            isPressed,
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    ServiceItem service,
    int index,
    bool isPressed,
  ) {
    final scale = isPressed ? 0.95 : 1.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: scale, end: scale),
      duration: Duration(milliseconds: 200),
      builder: (context, animatedScale, child) {
        return Transform.scale(scale: animatedScale, child: child);
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
            onTap: () {
              // Handle service tap
            },
            onTapDown: (_) {
              context.read<ServicesCubit>().pressCard(index);
            },
            onTapUp: (_) {
              context.read<ServicesCubit>().releaseCard();
            },
            onTapCancel: () {
              context.read<ServicesCubit>().releaseCard();
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: service.color.withOpacity(0.1),
            highlightColor: service.color.withOpacity(0.05),
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
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: service.color.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: service.color.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            service.image,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
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
    );
  }
}

class ServiceItem {
  final String title;
  final Color color;
  final bool isNew;
  final String image;

  ServiceItem({
    required this.image,
    required this.title,
    required this.color,
    required this.isNew,
  });
}
