import 'package:flutter/material.dart';

class DrawingArea extends StatelessWidget {
  final Widget child;

  const DrawingArea({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17), // Slightly smaller to account for border
        child: child,
      ),
    );
  }
}