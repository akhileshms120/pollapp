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
    
    // Setup Animation Controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Fade and Slide Animations for the text content
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

    // Start initial animation and auto-toggle
    _animationController.forward();
    _startAutoToggle();
  }

  /// Sets up a timer to automatically switch between 'Jurisdiction' and 'You're near to' states.
  void _startAutoToggle() {
    _autoToggleTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => _toggleState(),
    );
  }

  /// Toggles the state and restarts the transition animation.
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
    // NEW DIMENSIONS: Height 200.0, Width 500.0
    const double cardMaxHeight = 200.0;
    const double cardMaxWidth = 500.0;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: cardMaxHeight, // Max Height
          child: Container(
            constraints: const BoxConstraints(maxWidth: cardMaxWidth), // Max Width
            padding: const EdgeInsets.all(16), // Adjusted Padding
            decoration: BoxDecoration(
              // Gradient matching the original UI (orange/yellow fade)
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF9CC), 
                  Color(0xFFFFDDCC), 
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                
                // Changed to a Row for the wide aspect ratio
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  crossAxisAlignment: CrossAxisAlignment.center, // Center all content vertically
                  children: [
                    // --- Left Section (Text, Icon, Buttons) ---
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center, 
                        mainAxisAlignment: MainAxisAlignment.center, // Center content within column height
                        children: [
                          // Animated Icon (Toggles between 1 or 2 pins)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Row(
                              key: ValueKey<bool>(isNear), // Key drives the switch animation
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF8B0000), // Dark red
                                  size: 20, // Further reduced size
                                ),
                                if (isNear) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF8B0000), // Dark red
                                    size: 20, // Further reduced size
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 4), // Reduced spacing
                          
                          // Animated Text (Fades and Slides in)
                          FadeTransition(
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
                                      fontSize: 12, // Further reduced size
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const Text(
                                    "MUSEUM",
                                    style: TextStyle(
                                      fontSize: 20, // Further reduced size
                                      color: Color(0xFF4A0E0E), // Very dark red/brown
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0, 
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12), // Reduced spacing
                          
                          // Buttons with Scale Animation
                          Wrap(
                            spacing: 8, 
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: [
                              // Primary Button (Get Details)
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2C3E50), 
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16, // Reduced padding
                                    vertical: 8, // Reduced padding
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), 
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "Details", 
                                  style: TextStyle(
                                    fontSize: 12, // Further reduced size
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // Secondary Button (Refresh/Toggle)
                              OutlinedButton(
                                onPressed: _toggleState,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF2C3E50),
                                  padding: const EdgeInsets.all(6), // Reduced padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), 
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xFF2C3E50),
                                    width: 1.5, 
                                  ),
                                ),
                                child: const Icon(Icons.refresh, size: 16), // Reduced icon size
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), // Reduced spacing
                          
                          // Indicator Dots
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildIndicatorDot(context, isNear, 6), // Reduced dot size
                              const SizedBox(width: 6),
                              _buildIndicatorDot(context, !isNear, 6), // Reduced dot size
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 20), // Separator
                    
                    // --- Right Section - City Illustration (Fixed size for Row layout) ---
                    SizedBox(
                      // Size tailored to fit inside 200 height card
                      width: 180, 
                      height: 160, 
                      child: const _CityIllustration(), // Uses default internal sizes now
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Helper to build the state indicator dots
  Widget _buildIndicatorDot(BuildContext context, bool isActive, double size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isActive 
            ? const Color(0xFF8B0000) // Active dot color
            : Colors.grey[400], // Inactive dot color
        shape: BoxShape.circle,
      ),
    );
  }
}

// --- CITY ILLUSTRATION WIDGET (Preserves the Bouncing Pin Animation) ---
class _CityIllustration extends StatefulWidget {
  // Removed scale parameter, as we manage size via the parent SizedBox now
  const _CityIllustration({Key? key}) : super(key: key);

  @override
  State<_CityIllustration> createState() => _CityIllustrationState();
}

class _CityIllustrationState extends State<_CityIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // Loop the animation

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 5, // Reduced bounce height to fit 160 height
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
  }
  
  // Removed didUpdateWidget since the scale parameter is gone

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // No external Transform.scale needed, using internal fixed sizing
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Clouds (background element)
        Positioned(
          top: 10,
          right: 10,
          child: _buildCloud(20), // Reduced size
        ),
        Positioned(
          top: 20,
          right: 40,
          child: _buildCloud(12), // Reduced size
        ),
        
        // Buildings (positioned at the bottom)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBuilding(45, Colors.grey[400]!), // Reduced height
              const SizedBox(width: 4),
              _buildBuilding(60, Colors.grey[300]!), // Reduced height
              const SizedBox(width: 4),
              _buildBuilding(55, const Color(0xFF2C3E50)), // Reduced height
              const SizedBox(width: 4),
              _buildBuilding(40, Colors.grey[350]!), // Reduced height
            ],
          ),
        ),
        
        // Animated Bouncing Pin (Location Icon)
        Positioned(
          top: 5, // Adjusted position for new height
          right: 20,
          child: AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return Transform.translate(
                // Applies the vertical bounce
                offset: Offset(0, _bounceAnimation.value),
                child: const Icon(
                  Icons.location_on,
                  size: 50, // Reduced size
                  color: Color(0xFFFFC107), // Yellow pin color
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
    );
  }

  // Helper methods to draw building elements
  Widget _buildBuilding(double height, Color color) {
    return Container(
      width: 30, // Reduced width
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(3),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 3), // Reduced spacing
          for (int i = 0; i < (height ~/ 10); i++) ...[ // Adjusted window count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWindow(),
                _buildWindow(),
              ],
            ),
            const SizedBox(height: 3), // Reduced spacing
          ],
        ],
      ),
    );
  }

  Widget _buildWindow() {
    return Container(
      width: 3, // Reduced size
      height: 3, // Reduced size
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
