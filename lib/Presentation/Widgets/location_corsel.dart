import 'dart:async';
import 'package:flutter/material.dart';

// --- MAIN WIDGET ---
class LocationCard extends StatefulWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard>
    with SingleTickerProviderStateMixin {
  bool isNear = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _autoToggleTimer;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
    _startAutoToggle();
  }

  void _startAutoToggle() {
    _autoToggleTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => _toggleState(),
    );
  }

  void _toggleState() {
    setState(() {
      isNear = !isNear;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _autoToggleTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: double.infinity,decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: [ Color(0xFFFFF9CC), 
                     Color(0xFFFFDDCC), ]),
                     boxShadow:[BoxShadow(
                      color: Colors.black.withAlpha(1),
                      blurRadius: 15,
                      offset: const Offset(0,8)
                     )]
        ),
        child: _buildVerticalLayout(1000, 5),
      ),
    );
   
  }

  // Vertical layout for portrait phones
  Widget _buildVerticalLayout(double screenWidth, double contentPadding) {
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = contentPadding > 20;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          _buildAnimatedIcon(isLargeScreen),
                 _buildAnimatedText(isSmallScreen, isLargeScreen),
                  _buildIndicatorDots(isSmallScreen, isLargeScreen),
            ],
          ),
        ),
        SizedBox(width: 150,height: 150,
          child: CityIllustration()),
    ],);
  }

  // Horizontal layout for landscape and tablets
  Widget _buildHorizontalLayout(double screenWidth, double contentPadding) {
    final isSmallScreen = screenWidth < 600;
    final isLargeScreen = contentPadding > 20;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Section - Text and Buttons
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnimatedIcon(isLargeScreen),
              SizedBox(height: isLargeScreen ? 8 : (isSmallScreen ? 4 : 6)),
              _buildAnimatedText(isSmallScreen, isLargeScreen),
              SizedBox(height: isLargeScreen ? 12 : (isSmallScreen ? 8 : 12)),
              _buildButtons(isSmallScreen, isLargeScreen),
              SizedBox(height: isLargeScreen ? 8 : (isSmallScreen ? 6 : 8)),
              _buildIndicatorDots(isSmallScreen, isLargeScreen),
            ],
          ),
        ),
        
        SizedBox(width: isLargeScreen ? 24 : (isSmallScreen ? 12 : 20)),
        
        // Right Section - City Illustration
        Expanded(
          flex: 2,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isLargeScreen ? 220 : 200,
                maxHeight: isLargeScreen ? 160 : 140,
              ),
              child: const CityIllustration(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedIcon([bool isLargeScreen = false]) {
    final iconSize = isLargeScreen ? 20.0 : 16.0;
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Row(
        key: ValueKey<bool>(isNear),
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            color: const Color(0xFF8B0000),
            size: iconSize,
          ),
          if (isNear) ...[
            SizedBox(width: isLargeScreen ? 4 : 3),
            Icon(
              Icons.location_on,
              color: const Color(0xFF8B0000),
              size: iconSize,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedText(bool isSmallScreen, [bool isLargeScreen = false]) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isNear ? "You're near to" : "Jurisdiction",
              style: TextStyle(
                fontSize: isLargeScreen ? 11 : (isSmallScreen ? 8 : 9),
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "MUSEUM",
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : (isSmallScreen ? 14 : 15),
                color: const Color(0xFF4A0E0E),
                fontWeight: FontWeight.bold,
                letterSpacing: isLargeScreen ? 0.9 : 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(bool isSmallScreen, [bool isLargeScreen = false]) {
    return Wrap(
      spacing: isLargeScreen ? 5 : (isSmallScreen ? 2 : 3),
      runSpacing: isLargeScreen ? 5 : (isSmallScreen ? 2 : 3),
      alignment: WrapAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C3E50),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? 12 : (isSmallScreen ? 8 : 9),
              vertical: isLargeScreen ? 5 : (isSmallScreen ? 2 : 3),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Details",
            style: TextStyle(
              fontSize: isLargeScreen ? 10 : (isSmallScreen ? 8 : 9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: _toggleState,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2C3E50),
            padding: EdgeInsets.all(isLargeScreen ? 4 : (isSmallScreen ? 2 : 3)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(
              color: Color(0xFF2C3E50),
              width: 1.2,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Icon(Icons.refresh, size: isLargeScreen ? 12 : (isSmallScreen ? 9 : 10)),
        ),
      ],
    );
  }

  Widget _buildIndicatorDots(bool isSmallScreen, [bool isLargeScreen = false]) {
    final dotSize = isLargeScreen ? 4.5 : (isSmallScreen ? 3.0 : 3.5);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIndicatorDot(isNear, dotSize),
        SizedBox(width: isLargeScreen ? 4 : (isSmallScreen ? 2 : 3)),
        _buildIndicatorDot(!isNear, dotSize),
      ],
    );
  }

  Widget _buildIndicatorDot(bool isActive, double size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF8B0000) : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }
}

// --- CITY ILLUSTRATION WIDGET ---
class CityIllustration extends StatefulWidget {
  const CityIllustration({Key? key}) : super(key: key);

  @override
  State<CityIllustration> createState() => _CityIllustrationState();
}

class _CityIllustrationState extends State<CityIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 5,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Scale illustration based on available space
        final scale = (constraints.maxWidth / 180).clamp(0.5, 1.2);
        
        return Transform.scale(
          scale: scale,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // Clouds
              Positioned(
                top: 10,
                right: 10,
                child: _buildCloud(20),
              ),
              Positioned(
                top: 20,
                right: 40,
                child: _buildCloud(12),
              ),
              
              // Buildings
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBuilding(45, Colors.grey[400]!),
                    const SizedBox(width: 4),
                    _buildBuilding(60, Colors.grey[300]!),
                    const SizedBox(width: 4),
                    _buildBuilding(55, const Color(0xFF2C3E50)),
                    const SizedBox(width: 4),
                    _buildBuilding(40, Colors.grey[350]!),
                  ],
                ),
              ),
              
              // Animated Bouncing Pin
              Positioned(
                top: 5,
                right: 20,
                child: AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _bounceAnimation.value),
                      child: const Icon(
                        Icons.location_on,
                        size: 50,
                        color: Color(0xFFFFC107),
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBuilding(double height, Color color) {
    return Container(
      width: 30,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(3),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 3),
          for (int i = 0; i < (height ~/ 10); i++) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWindow(),
                _buildWindow(),
              ],
            ),
            const SizedBox(height: 3),
          ],
        ],
      ),
    );
  }

  Widget _buildWindow() {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  Widget _buildCloud(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }
}