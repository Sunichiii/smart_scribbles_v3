import 'package:flutter/material.dart';
import 'package:smart_scribbles/screens/practice_screen.dart';
import 'package:smart_scribbles/widgets/category_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Category',
          style: GoogleFonts.fredoka(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CategoryCard(
                title: 'Alphabets',
                description: 'Learn to write A to Z',
                icon: Icons.abc,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PracticeScreen(
                        category: 'alphabets',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CategoryCard(
                title: 'Numbers',
                description: 'Learn to write 0 to 9',
                icon: Icons.numbers,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PracticeScreen(
                        category: 'numbers',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
