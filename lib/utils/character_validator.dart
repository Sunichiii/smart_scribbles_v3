import 'package:flutter/material.dart';
import 'package:smart_scribbles/models/drawing_point.dart';

class CharacterValidator {
  static bool validateDrawing(
    List<DrawingPoint> points,
    String character,
    Size canvasSize,
  ) {
    if (points.isEmpty) {
      return false;
    }

    // Calculate bounding box of the drawing
    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    // Check if any point is outside the drawing area
    for (var point in points) {
      if (point.offset.dx < 0 ||
          point.offset.dx > canvasSize.width ||
          point.offset.dy < 0 ||
          point.offset.dy > canvasSize.height) {
        return false;
      }

      minX = point.offset.dx < minX ? point.offset.dx : minX;
      maxX = point.offset.dx > maxX ? point.offset.dx : maxX;
      minY = point.offset.dy < minY ? point.offset.dy : minY;
      maxY = point.offset.dy > maxY ? point.offset.dy : maxY;
    }

    // Check if the drawing is too small relative to the canvas size
    double minDrawingSize = canvasSize.width * 0.2; // At least 20% of canvas width
    if ((maxX - minX) < minDrawingSize || (maxY - minY) < minDrawingSize) {
      return false;
    }

    // Check if the drawing has enough points for a proper character
    if (points.length < 50) {
      return false;
    }

    // Check if the drawing stays within reasonable bounds
    double maxAllowedSize = canvasSize.width * 0.9; // Maximum 90% of canvas width
    if ((maxX - minX) > maxAllowedSize || (maxY - minY) > maxAllowedSize) {
      return false;
    }

    return true;
  }
}