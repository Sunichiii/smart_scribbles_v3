import 'package:flutter/material.dart';
import 'package:smart_scribbles/models/drawing_point.dart';

class DrawingCanvas extends StatefulWidget {
  final List<DrawingPoint?> points; // Updated to allow null values
  final Function(List<DrawingPoint?>) onUpdatePoints; // Updated callback type
  final Color selectedColor;

  const DrawingCanvas({
    super.key,
    required this.points,
    required this.onUpdatePoints,
    required this.selectedColor,
  });

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);

        // Add null to break the line between gestures
        final newPoints = List<DrawingPoint?>.from(widget.points)
          ..add(null) // Insert null as a separator
          ..add(
            DrawingPoint(
              offset: offset,
              paint: Paint()
                ..color = widget.selectedColor
                ..strokeWidth = 6
                ..strokeCap = StrokeCap.round
                ..strokeJoin = StrokeJoin.round,
            ),
          );

        widget.onUpdatePoints(newPoints);
      },
      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);

        final newPoints = List<DrawingPoint?>.from(widget.points)
          ..add(
            DrawingPoint(
              offset: offset,
              paint: Paint()
                ..color = widget.selectedColor
                ..strokeWidth = 6
                ..strokeCap = StrokeCap.round
                ..strokeJoin = StrokeJoin.round,
            ),
          );

        widget.onUpdatePoints(newPoints);
      },
      child: CustomPaint(
        painter: DrawingPainter(points: widget.points), // Pass the nullable points
        child: Container(),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> points; // Updated to allow null values

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      // Skip drawing if the current or next point is null
      if (points[i] == null || points[i + 1] == null) {
        continue;
      }

      canvas.drawLine(
        points[i]!.offset, // Use ! because we know it's non-null here
        points[i + 1]!.offset,
        points[i]!.paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
