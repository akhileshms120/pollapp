import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:video_player/video_player.dart';

class OneboardingScreen extends StatefulWidget {
  const OneboardingScreen({super.key});

  @override
  State<OneboardingScreen> createState() => _OneboardingScreenState();
}

class _OneboardingScreenState extends State<OneboardingScreen> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/vd1.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen video (replaces GIF)
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const SizedBox.expand(
              child: Center(child: CircularProgressIndicator()),
            ),
          // Optional: Add your content here
          const Center(child: Text("Your content")),
        ],
      ),
    );
  }
}