import 'dart:async';
import 'package:bootcamp_task/features/startScreens/onboarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _imageController;

  late Animation<double> _textFadeAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _textFadeAnimation =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);
    _textController.forward();
    _imageController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _imageFadeAnimation =
        CurvedAnimation(parent: _imageController, curve: Curves.easeIn);
    _imageScaleAnimation = Tween<double>(begin: 1.07, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );
    _imageController.forward();
    Timer(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Onboarding()),
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 250, 240, 243),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: _imageFadeAnimation,
              child: ScaleTransition(
                scale: _imageScaleAnimation,
                child: Image.network(
                  'https://i.pinimg.com/736x/8d/ec/8a/8dec8af369b787b7138067c4985a2af5.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: FadeTransition(
                opacity: _textFadeAnimation,
                child: Text(
                  "✨trendy store✨",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.08,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        blurRadius: 5,
                        offset: Offset(2, 2),
                        color: Color.fromARGB(255, 170, 89, 36),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: FadeTransition(
                opacity: _textFadeAnimation,
                child: Text(
                  "Any shopping just from home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        blurRadius: 5,
                        offset: Offset(2, 2),
                        color: Color.fromARGB(255, 170, 89, 36),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
