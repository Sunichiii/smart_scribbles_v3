import 'package:flutter/material.dart';
import 'dart:math';

class ConfettiOverlay extends StatefulWidget {
  @override
  _ConfettiOverlayState createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Confetti> confetti;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    confetti = List.generate(
      50,
      (index) => Confetti(
        color: Color.fromRGBO(
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
          1,
        ),
        position: Offset(
          random.nextDouble() * 400,
          random.nextDouble() * -100,
        ),
        speed: random.nextDouble() * 200 + 200,
        angle: random.nextDouble() * pi / 2 + pi / 4,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var particle in confetti) {
          particle.update(_controller.value);
        }
        return CustomPaint(
          size: Size.infinite,
          painter: ConfettiPainter(particles: confetti),
        );
      },
    );
  }
}

class Confetti {
  Color color;
  Offset position;
  double speed;
  double angle;

  Confetti({
    required this.color,
    required this.position,
    required this.speed,
    required this.angle,
  });

  void update(double time) {
    position = Offset(
      position.dx + cos(angle) * speed * time,
      position.dy + sin(angle) * speed * time,
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final List<Confetti> particles;

  ConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var particle in particles) {
      paint.color = particle.color;
      canvas.drawCircle(particle.position, 4, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}