import 'package:flutter/material.dart';

class TemplatePainter extends CustomPainter {
  final String character;

  TemplatePainter({required this.character});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textPainter = TextPainter(
      text: TextSpan(
        text: character,
        style: TextStyle(
          fontSize: size.width * 0.6,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}