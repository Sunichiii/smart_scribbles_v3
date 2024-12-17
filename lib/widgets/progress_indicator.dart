import 'package:flutter/material.dart';
import 'package:smart_scribbles/theme/app_colors.dart';

class LearningProgressIndicator extends StatelessWidget {
  final String category;
  final String currentCharacter;

  const LearningProgressIndicator({
    super.key,
    required this.category,
    required this.currentCharacter,
  });

  double _calculateProgress() {
    if (category == 'alphabets') {
      return (currentCharacter.codeUnitAt(0) - 'A'.codeUnitAt(0) + 1) / 26;
    } else {
      return (int.parse(currentCharacter) + 1) / 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PROGRESS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${(_calculateProgress() * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: _calculateProgress(),
          backgroundColor: AppColors.backgroundLight,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 15,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}