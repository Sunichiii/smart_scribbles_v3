import 'package:flutter/material.dart';
import 'package:smart_scribbles/theme/app_colors.dart';

class AchievementBadge extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isUnlocked;

  const AchievementBadge({
    super.key,
    required this.title,
    required this.icon,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUnlocked ? AppColors.secondary : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
            color: isUnlocked ? Colors.white : Colors.grey[600],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isUnlocked ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}