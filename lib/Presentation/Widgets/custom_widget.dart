import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/logs/app_logger.dart';

class CustomWidget {
  //////////////////// Text Widget ///////////////////////////////////////////////////////////////////////////////

 
  static Widget customTextWidget({
    required String text,
    double? height,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color? textColor,
    Color? backgroundColor, 
    TextOverflow? overflow,
    TextAlign? textAlign = TextAlign.start,
    TextDecoration? textDecoration

  }) {
    try {
      return Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
      
        style: TextStyle(
          
          height: height,
          decoration:textDecoration ,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor ?? AppColor.blackColor, 
          backgroundColor: backgroundColor,
        ),
      );
    } catch (e, stackTrace) {
      LogService.error("Error in customTextWidget: $e",);
      if (kDebugMode) {
        debugPrint('Stack trace: $stackTrace'); 
      }
      return Text(
        "Error: $text", 
        style: TextStyle(
          color: AppColor.errorMessage,
          fontSize: 14.0,
          backgroundColor: Colors.red.withOpacity(0.1), 
        ),
      );
    }
  }

  //////////////////////////////////////////// Image Widget ///////////////////////////////////////

 

static Widget customImageWidget({
  required String imagePath,
  double width = 100.0,
  double height = 100.0,
  BoxFit fit = BoxFit.cover,
  double borderRadius = 0.0,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        LogService.error("Error loading image '$imagePath': $error");
        if (kDebugMode) debugPrint('Stack trace: $stackTrace');
        return Icon(Icons.broken_image, size: width, color: AppColor.errorMessage);
      },
    ),
  );
}


  static Widget customSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }


  static Widget verticalSpacer(double height) => SizedBox(height: height);
  static Widget horizontalSpacer(double width) => SizedBox(width: width);





  static Widget iconWidget({required IconData icon, Color? iconColor,bool isDarkMode=false}){
    return Icon(icon,color: AppColor.getIconBackgroundColor(isDarkMode),);
  }

 //////////////////////Custom widget for privacy and terms and condtion/////////////////////////////////////////////////


  static Widget buildHeading(String headtext,bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child:CustomWidget.customTextWidget(text: headtext,textColor:AppColor.getTextColor(isDarkMode), fontSize: 20,fontWeight: FontWeight.bold )
    );
  }
 static Widget buildParagraph(String text,bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child:CustomWidget.customTextWidget(text:text,fontSize: 16,height: 1.5,textColor:AppColor.getTextColor(isDarkMode),textAlign:TextAlign.justify  )

    );
  }
/////////////Circular Indicator Loading Screen////////////////////////////////////////////////////
static Widget loadingIndicator({bool isDarkMode = false, String? label}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
      if (label != null) ...[
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    ],
  );








}

//////////////////////////Error display///////////////////////////////////////////////////////////
static Widget errorDisplay({
  required String message,
  required VoidCallback onRetry,
  bool isDarkMode = false,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.error_outline,
          color: isDarkMode ? Colors.red.shade300 : Colors.red.shade700,
          size: 50),
      const SizedBox(height: 20),
      Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 16),
      ElevatedButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
        label: const Text('Retry'),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDarkMode ? Colors.grey[800] : Colors.blueAccent.shade100,
          foregroundColor: isDarkMode ? Colors.white : Colors.blue.shade900,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    ],
  );
}




}

class CustomGradientBackground extends StatelessWidget {
  final bool isDarkMode;
  final Widget child;

  const CustomGradientBackground({
    Key? key,
    required this.isDarkMode,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [const Color(0xFF212121), const Color(0xFF0D47A1)]
              : [const Color(0xFFE3F2FD), const Color(0xFF1976D2)],
        ),
      ),
      child: child,
    );
  }
}

/// Animated Logo Widget - Reusable for splash, onboarding, etc.
class CustomAnimatedLogo extends StatelessWidget {
  final double size;
  final String imagePath;
  final bool isDarkMode;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  const CustomAnimatedLogo({
    Key? key,
    required this.size,
    required this.imagePath,
    required this.isDarkMode,
    required this.fadeAnimation,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: (isDarkMode
                        ? const Color(0xFF1976D2)
                        : Colors.black.withOpacity(0.2))
                    .withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CustomWidget.customImageWidget(
            imagePath: imagePath,
            height: size * 0.67,
            width: size * 0.67,
          ),
        ),
      ),
    );
  }
}

/// Animated Header with Title and Subtitle - Reusable
class CustomAnimatedHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDarkMode;
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;

  const CustomAnimatedHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isDarkMode,
    required this.fadeAnimation,
    required this.slideAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, slideAnimation.value),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: isDarkMode
                    ? [Colors.white, const Color(0xFF64B5F6)]
                    : [Colors.white, const Color(0xFFBBDEFB)],
              ).createShader(bounds),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: isDarkMode
                              ? const Color(0xFF0D47A1)
                              : Colors.black26,
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDarkMode
                        ? Colors.white70
                        : Colors.white.withOpacity(0.9),
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Loading Indicator Widget - Reusable
class CustomLoadingIndicator extends StatelessWidget {
  final String message;
  final bool isDarkMode;
  final Animation<double> fadeAnimation;

  const CustomLoadingIndicator({
    Key? key,
    required this.message,
    required this.isDarkMode,
    required this.fadeAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                isDarkMode ? Colors.white : Colors.white,
              ),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? Colors.white70
                      : Colors.white.withOpacity(0.8),
                  letterSpacing: 1.0,
                ),
          ),
        ],
      ),
    );
  }
}

/// Error Display Widget with Retry - Reusable
class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final bool isDarkMode;
  final String? message;

  const CustomErrorWidget({
    Key? key,
    required this.onRetry,
    required this.isDarkMode,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: isDarkMode
                      ? Colors.red.shade300
                      : Colors.red.shade100,
                  size: 50,
                ),
                const SizedBox(height: 20),
                if (message != null) ...[
                  Text(
                    message!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.white70 : Colors.white,
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
                CustomStyledButton(
                  text: 'Retry',
                  onPressed: onRetry,
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Styled Button Widget - Reusable
class CustomStyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDarkMode;
  final ButtonVariant variant;

  const CustomStyledButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isDarkMode,
    this.variant = ButtonVariant.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = isDarkMode
            ? Colors.grey[800]!
            : Colors.white.withOpacity(0.9);
        foregroundColor = isDarkMode ? Colors.white : const Color(0xFF1976D2);
        break;
      case ButtonVariant.secondary:
        backgroundColor = const Color(0xFF2196F3);
        foregroundColor = Colors.white;
        break;
      case ButtonVariant.success:
        backgroundColor = const Color(0xFF4CAF50);
        foregroundColor = Colors.white;
        break;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 5,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
      ),
    );
  }
}

/// Button Variants
enum ButtonVariant {
  primary,
  secondary,
  success,
}