import 'package:flutter/material.dart';
import 'package:smart_scribbles/screens/splash_screen.dart';
import 'package:smart_scribbles/theme/app_theme.dart';

void main() {
  runApp(const SmartScribblesApp());
}

class SmartScribblesApp extends StatelessWidget {
  const SmartScribblesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Scribbles',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}