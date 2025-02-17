import 'package:flutter/material.dart';
import 'main.dart'; // Import the main game screen

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({super.key});

  @override
  DifficultyScreenState createState() => DifficultyScreenState();
}

class DifficultyScreenState extends State<DifficultyScreen> {
  int selectedDifficulty = 2; // Default to Medium

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Difficulty")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Difficulty Selection
            Text("Choose AI Difficulty", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            DropdownButton<int>(
              value: selectedDifficulty,
              items: [
                DropdownMenuItem(value: 1, child: Text("Easy")),
                DropdownMenuItem(value: 2, child: Text("Medium")),
                DropdownMenuItem(value: 3, child: Text("Hard")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            SizedBox(height: 40),

            // Start Game Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicTacToeScreen(
                      isSinglePlayer: true,
                      difficulty: selectedDifficulty,
                      theme: 1, // Default Black Theme
                    ),
                  ),
                );
              },
              child: Text("Start Game 🎮"),
            ),
          ],
        ),
      ),
    );
  }
}
