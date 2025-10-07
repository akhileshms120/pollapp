import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart' as Routes;

class FingerprintLoginButton extends StatefulWidget {
  final bool isDarkMode;
  final double fingerprintSize;
  final double verticalSpacing;

  const FingerprintLoginButton({
    Key? key,
    required this.isDarkMode,
    required this.fingerprintSize,
    required this.verticalSpacing,
  }) : super(key: key);

  @override
  State<FingerprintLoginButton> createState() => _FingerprintLoginButtonState();
}

class _FingerprintLoginButtonState extends State<FingerprintLoginButton>
    with TickerProviderStateMixin {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;
  bool _isAuthenticated = false;
  bool _canCheckBiometrics = false;
  String _authError = '';

  // Animation controllers for rotation and scale
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkBiometrics();
  }

  void _initializeAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  Future<void> _checkBiometrics() async {
    bool canCheck = await _localAuth.canCheckBiometrics;
    setState(() {
      _canCheckBiometrics = canCheck;
    });
  }

  Future<void> _authenticate() async {
    if (!_canCheckBiometrics) {
      _showError('Biometrics not available on this device.');
      return;
    }

    setState(() {
      _isAuthenticating = true;
      _authError = '';
    });

    // Start rotation animation
    _rotationController.repeat();

    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to log in',
        options: const AuthenticationOptions(
          biometricOnly: true, // Force biometrics (no device PIN fallback)
          stickyAuth: true,    // Keep dialog open if interrupted
        ),
      );

      if (authenticated) {
        setState(() {
          _isAuthenticated = true;
        });
        // Success animation
        _scaleController.forward().then((_) => _scaleController.reverse());
        _onSuccess(); // Navigate or perform login action
      } else {
        _showError('Authentication failed. Please try again.');
      }
    } catch (e) {
      _showError('Error: $e');
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
      _rotationController.stop();
      _rotationController.reset();
    }
  }

  void _showError(String error) {
    setState(() {
      _authError = error;
    });
    // Auto-hide error after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _authError = '');
    });
  }

  void _onSuccess() {
    Get.toNamed(RoutesName.homeScreen);
    // TODO: Navigate to home screen or perform login
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Login successful! 🎉')),
    // );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _isAuthenticating ? null : _authenticate,
          child: AnimatedBuilder(
            animation: Listenable.merge([_rotationAnimation, _scaleAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getIconColor(),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.getShadowColor(widget.isDarkMode)
                              .withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.fingerprint,
                      size: widget.fingerprintSize,
                      color: _getIconForegroundColor(),
                      semanticLabel: "Login with fingerprint",
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (_authError.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _authError,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(height: widget.verticalSpacing),
      ],
    );
  }

  Color _getIconColor() {
    if (_isAuthenticated) return Colors.green;
    if (_isAuthenticating) return Colors.blue;
    return Colors.transparent; // Or your AppColor.getIconBackgroundColor(widget.isDarkMode)
  }

  Color _getIconForegroundColor() {
    if (_isAuthenticated) return Colors.white;
    if (_isAuthenticating) return Colors.white;
    return Colors.black; // Or your AppColor
  }
}