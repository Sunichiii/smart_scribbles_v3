import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_scribbles/models/drawing_point.dart';
import 'package:smart_scribbles/theme/app_colors.dart';
import 'package:smart_scribbles/utils/character_validator.dart';
import 'package:smart_scribbles/widgets/drawing_canvas.dart';
import 'package:smart_scribbles/widgets/template_painter.dart';
import 'package:smart_scribbles/widgets/drawing_area.dart';
import 'package:smart_scribbles/widgets/color_picker.dart';
import 'package:smart_scribbles/widgets/progress_indicator.dart';
import 'package:smart_scribbles/widgets/achievement_badge.dart';
import '../widgets/confetti_overlay.dart';

class PracticeScreen extends StatefulWidget {
  final String category;

  const PracticeScreen({
    super.key,
    required this.category,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  // Update points to allow nullable values
  List<DrawingPoint?> points = [];
  String currentCharacter = '';
  Color selectedColor = AppColors.drawingColors[0];
  int correctAttempts = 0;
  bool showConfetti = false;

  @override
  void initState() {
    super.initState();
    currentCharacter = widget.category == 'alphabets' ? 'A' : '0';
  }

  void _checkDrawing() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    // Pass a non-nullable filtered version of points for validation
    bool isCorrect = CharacterValidator.validateDrawing(
      points.whereType<DrawingPoint>().toList(), // Filter null values
      currentCharacter,
      size,
    );

    if (isCorrect) {
      setState(() {
        correctAttempts++;
        showConfetti = true;
      });

      // Hide confetti after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showConfetti = false;
          });
        }
      });
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            isCorrect ? 'Great Job! 🎉' : 'Try Again! 💪',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isCorrect
                  ? 'You drew it correctly!'
                  : points.isEmpty
                  ? 'Please draw something first!'
                  : 'Keep practicing, you will get better!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (isCorrect && (correctAttempts % 5 == 0))
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AchievementBadge(
                  title: 'Five in a row',
                  icon: Icons.star,
                  isUnlocked: true,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isCorrect) {
                _moveToNext();
              }
              setState(() {
                points.clear();
              });
            },
            child: Center(child: const Text('OK',style: TextStyle(fontWeight: FontWeight.bold),)),
          ),
        ],
      ),
    );
  }

  void _moveToNext() {
    setState(() {
      if (widget.category == 'alphabets') {
        if (currentCharacter == 'Z') {
          Navigator.pop(context);
        } else {
          currentCharacter = String.fromCharCode(
            currentCharacter.codeUnitAt(0) + 1,
          );
        }
      } else {
        if (currentCharacter == '9') {
          Navigator.pop(context);
        } else {
          currentCharacter = (int.parse(currentCharacter) + 1).toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice ${widget.category}', style: GoogleFonts.fredoka(fontSize: 24),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LearningProgressIndicator(
              category: widget.category,
              currentCharacter: currentCharacter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Draw "$currentCharacter"',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DrawingArea(
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: TemplatePainter(character: currentCharacter),
                          child: Container(),
                        ),
                        DrawingCanvas(
                          points: points,
                          selectedColor: selectedColor,
                          onUpdatePoints: (newPoints) {
                            setState(() {
                              points = newPoints;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (showConfetti)
                  ConfettiOverlay(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ColorPicker(
              selectedColor: selectedColor,
              onColorSelected: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      points.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _checkDrawing,
                  icon: const Icon(Icons.check),
                  label: const Text('Check'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
