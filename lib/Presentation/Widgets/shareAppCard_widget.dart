import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class SharePolAppCard extends StatelessWidget {
  const SharePolAppCard({Key? key}) : super(key: key);

  final String shareText = """
POL-APP
Official App of Kerala Police with more than 35 services

Download Pol-App to get our services at your fingertips

Android: https://play.google.com/store/apps/details?id=com.keralapolice&hl=en_IN
iOS: https://apps.apple.com/in/app/pol-app-kerala-police/id1500016489
""";

  void _shareApp(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(
      ShareParams(text:shareText,subject:'Check out the official Kerala Police App!',sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,  )
   
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration:
      
      
 BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
  gradient: LinearGradient(
    colors: [
      Colors.white.withOpacity(0.3),
      Colors.blueGrey.withOpacity(0.2),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(2, 4),
    ),
  ],
),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Text & Button
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share Pol-App\nand make\nKerala safer for\neveryone',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A), // Kerala Police navy blue tone

                          // Colors.white.withOpacity(0.95),
                          height: 1.3,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () => _shareApp(context),
                        style:
                         ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.4),
                          foregroundColor: const Color(0xFF1E3A5B),
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.3)),
                          ),
                        ),
                        child: const Text(
                          
                          'Share Now',
                          style: TextStyle(
                            color:  Color(0xFF1A1A1A), // Kerala Police navy blue tone

                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Right: Image
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    'assets/images/new/Share.png',
                    fit: BoxFit.contain,
                    height: 130,
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
