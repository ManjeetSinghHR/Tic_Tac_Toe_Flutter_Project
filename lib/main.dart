import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/game_mode_screen.dart';

void main() {
  runApp(TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  const TicTacToeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: GameModeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  final bool isSinglePlayer;
  final int difficulty; // AI Difficulty
  final int theme;
  const TicTacToeScreen({super.key, required this.isSinglePlayer, required this.difficulty, required this.theme});

  @override
  TicTacToeScreenState createState() => TicTacToeScreenState();
}

class TicTacToeScreenState extends State<TicTacToeScreen> {
  int playerWins = 0;
  int aiWins = 0;
  int draws = 0;

  List<int> winningTiles = []; // Store the indexes of the winning tiles
  List<String> board = List.filled(9, '');
  bool isXturn = true;
  bool gameEnded = false;
  String winner = '';

  void _aiMove() {
    int bestMove = _findBestMove();
    if (bestMove != -1) {
      setState(() {
        board[bestMove] = 'O';
        isXturn = true;
      });
  
      _playSound("assets/sounds/click-button.mp3");
  
      List<int>? result = _checkWinner();
      if (result != null) {
        setState(() {
          gameEnded = true;
          winningTiles = result.isEmpty ? [] : result;
          winner = result.isEmpty ? 'Draw' : board[result[0]];
  
          // ✅ Update Scoreboard for AI
          if (winner == 'X') {
            playerWins++; // Player Score Updates
          } else if (winner == 'O') {
            aiWins++; // ✅ AI Score Updates Correctly Now
          } else {
            draws++; // Draw Score Updates
          }
        });
  
        _playSound(winner == 'Draw'
            ? "assets/sounds/match-draw.mp3"
            : "assets/sounds/win-sound.mp3");
  
        _showResultDialog();
      }
    }
  }

  int _findBestMove() {
    if (widget.difficulty == 1) { // Easy Mode
      List<int> emptyCells = [];
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') emptyCells.add(i);
      }
      return emptyCells.isNotEmpty ? emptyCells[Random().nextInt(emptyCells.length)] : -1;
    } 
  
    if (widget.difficulty == 2 && Random().nextBool()) { // Medium Mode (50% chance AI plays random)
      List<int> emptyCells = [];
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') emptyCells.add(i);
      }
      return emptyCells.isNotEmpty ? emptyCells[Random().nextInt(emptyCells.length)] : -1;
    }
  
    // Hard Mode (Minimax)
    int bestScore = -1000;
    int bestMove = -1;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = _minimax(board, 0, false);
        board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  int _minimax(List<String> newBoard, int depth, bool isMaximizing) {
    String? result = _evaluateWinner();
    if (result != null) {
      if (result == 'O') return 10 - depth; // AI Wins
      if (result == 'X') return depth - 10; // Player Wins
      return 0; // Draw
    }
  
    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i] == '') {
          newBoard[i] = 'O';
          int score = _minimax(newBoard, depth + 1, false);
          newBoard[i] = '';
          bestScore = max(bestScore, score);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i] == '') {
          newBoard[i] = 'X';
          int score = _minimax(newBoard, depth + 1, true);
          newBoard[i] = '';
          bestScore = min(bestScore, score);
        }
      }
      return bestScore;
    }
  }

  @override
  void initState() {
    super.initState();
    _playSound("assets/sounds/game-start.mp3");
  }

  void _playSound(String path) async {
    AudioPlayer player = AudioPlayer(); // Create a new player instance
    await player.play(AssetSource(path.split('/').sublist(1).join('/')));

    // Allow the sound to finish playing before disposing
    player.onPlayerComplete.listen((event) {
      player.dispose(); 
    });
  }

  void _onTileTap(int index) {
    if (board[index] == '' && !gameEnded) {
      setState(() {
        board[index] = isXturn ? 'X' : 'O';
        isXturn = !isXturn;
      });
  
      _playSound("assets/sounds/click-button.mp3");
  
      List<int>? result = _checkWinner();
      if (result != null) {
        setState(() {
          gameEnded = true;
          winningTiles = result.isEmpty ? [] : result;
          winner = result.isEmpty ? 'Draw' : board[result[0]];
  
          // ✅ Update Scoreboard
          if (winner == 'X') {
            playerWins++; // Increase Player Score
          } else if (winner == 'O') {
            aiWins++; // Increase AI Score
          } else {
            draws++; // Increase Draw Count
          }
        });
  
        _playSound(winner == 'Draw'
            ? "assets/sounds/match-draw.mp3"
            : "assets/sounds/win-sound.mp3");
  
        _showResultDialog();
      }
  
      // AI Move (if Single Player & not game over)
      if (widget.isSinglePlayer && !isXturn && !gameEnded) {
        Future.delayed(Duration(milliseconds: 500), () {
          _aiMove();
        });
      }
    }
  }

  String? _evaluateWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]  // Diagonals
    ];
  
    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return board[pattern[0]]; // Return 'X' or 'O'
      }
    }
  
    if (!board.contains('')) return 'Draw';
    return null; // No winner yet
  }

  List<int>? _checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]  // Diagonals
    ];
  
    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return pattern; // Return winning positions
      }
    }
  
    if (!board.contains('')) return []; // Return empty list for draw
    return null;
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              winner == 'Draw'
                  ? "assets/animations/match-draw-AM.json"
                  : "assets/animations/win-AM.json",
              repeat: false,
            ),
            Text(
              winner == 'Draw' ? "It's a Draw!" : "$winner Wins!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _resetGame();
              },
              child: Text("Play Again"),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      isXturn = true;
      gameEnded = false;
      winner = '';
      winningTiles = [];
    });
  
    _playSound("assets/sounds/game-start.mp3");
  
    // If AI is playing as "O", let it make the first move
    if (widget.isSinglePlayer && !isXturn) {
      Future.delayed(Duration(milliseconds: 500), () {
        _aiMove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tic Tac Toe"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Player: $playerWins", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Draws: $draws", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("AI: $aiWins", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              // Define tile color based on theme
              Color tileColor;
              if (widget.theme == 1) {
                tileColor = Colors.grey[900]!; // Dark Mode
              } else if (widget.theme == 2) {
                tileColor = Colors.purpleAccent; // Neon Mode
              } else {
                tileColor = Colors.white; // Classic Mode
              }
          
              return GestureDetector(
                onTap: () => _onTileTap(index),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: winningTiles.contains(index)
                        ? Color.fromARGB(180, 0, 255, 0) // Highlight winning tiles
                        : tileColor, // Apply selected theme color
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: winningTiles.contains(index)
                        ? [
                            BoxShadow(
                              color: Color.fromARGB(204, 0, 255, 0),
                              blurRadius: 15,
                              spreadRadius: 3,
                            )
                          ]
                        : [],
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Text(
                        board[index],
                        key: ValueKey(board[index]),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: board[index] == 'X' ? Colors.red : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          if (gameEnded)
            ElevatedButton(
              onPressed: _resetGame,
              child: Text("Restart Game"),
            ),
        ],
      ),
    );
  }
}