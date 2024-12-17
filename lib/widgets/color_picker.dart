import 'package:flutter/material.dart';
import 'package:smart_scribbles/theme/app_colors.dart';

class ColorPicker extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AppColors.drawingColors.length,
          itemBuilder: (context, index) {
            final color = AppColors.drawingColors[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: GestureDetector(
                onTap: () => onColorSelected(color),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedColor == color ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}