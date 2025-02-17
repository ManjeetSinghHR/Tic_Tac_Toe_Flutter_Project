import 'package:flutter/material.dart';
import 'difficulty_screen.dart'; // Import new screen for difficulty selection
import 'main.dart'; // Import main game screen

class GameModeScreen extends StatelessWidget {
  const GameModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Game Mode")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DifficultyScreen()),
                );
              },
              child: Text("Single Player (vs AI) 🤖"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicTacToeScreen(
                      isSinglePlayer: false,
                      difficulty: 2, // Default (Ignored in Two Player Mode)
                      theme: 1, // Default Theme
                    ),
                  ),
                );
              },
              child: Text("Two Players 🎮"),
            ),
          ],
        ),
      ),
    );
  }
}
