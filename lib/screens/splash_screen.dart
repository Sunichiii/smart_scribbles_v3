import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_scribbles/screens/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToIntro();
  }

  _navigateToIntro() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const IntroductionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/pencil-drawing.json',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 70),
            Text(
              'SMART',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'SCRIBBLES',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}