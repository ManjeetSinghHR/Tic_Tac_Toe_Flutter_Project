<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tic Tac Toe - Flutter Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #ffffff;
            margin: 20px;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
        }
        .section {
            margin-bottom: 20px;
        }
        .section h2 {
            border-bottom: 2px solid #ff9800;
            padding-bottom: 5px;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        ul li::before {
            content: "\2714\0020"; /* Unicode checkmark */
            color: #4CAF50;
        }
        .highlight {
            color: #ff9800;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🕹 Tic Tac Toe - Flutter Game</h1>
        <p>A modern and interactive Tic Tac Toe game built using <span class="highlight">Flutter</span>. This game allows players to play in Single Player (AI) mode or Two Players mode with a beautiful animated UI, sound effects, and winning highlights.</p>
        
        <div class="section">
            <h2>📌 Features</h2>
            <ul>
                <li><strong>Two Game Modes:</strong> Single Player (vs AI) with 3 difficulty levels (Easy, Medium, Hard). Two Players Mode to play with a friend.</li>
                <li><strong>Smart AI (Minimax Algorithm):</strong> The AI never loses! Easy Mode → AI makes random moves. Medium Mode → AI makes some mistakes. Hard Mode → AI plays optimally using Minimax.</li>
                <li><strong>Smooth Animations & Effects:</strong> X & O animate when placed on the board. Winning tiles glow green with a pulsing animation. Sound effects for game events (click, win, draw, restart).</li>
                <li><strong>Scoreboard Tracking:</strong> Tracks Player Wins, AI Wins, and Draws.</li>
                <li><strong>Beautiful UI (Dark Theme):</strong> Modern and minimalistic design with dark mode. Neatly arranged grid with glowing effects.</li>
                <li><strong>Restart Game Option:</strong> Players can restart the match anytime.</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>📌 Tech Stack</h2>
            <ul>
                <li>🚀 <span class="highlight">Flutter (Dart)</span> → Cross-platform framework for mobile apps.</li>
                <li>🎨 <span class="highlight">Lottie</span> → For animated winning effects.</li>
                <li>🎵 <span class="highlight">audioplayers</span> → For sound effects.</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>📌 Platforms Supported</h2>
            <ul>
                <li>✅ Android 📱</li>
                <li>✅ iOS (Can be extended with minor changes)</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>📌 How to Play</h2>
            <ol>
                <li>Select "Single Player" (to play vs AI) or "Two Players" (to play with a friend).</li>
                <li>If Single Player, select AI difficulty (Easy, Medium, Hard).</li>
                <li>The game begins! Tap on any empty tile to place X or O.</li>
                <li>First to get 3 in a row (Horizontally, Vertically, or Diagonally) wins!</li>
                <li>If no moves are left, it's a Draw!</li>
                <li>After the game, you can Restart and play again.</li>
            </ol>
        </div>
        
        <div class="section">
            <h2>📌 Contributing</h2>
            <p>🚀 If you’d like to enhance the game, feel free to submit a pull request!</p>
        </div>
        
        <div class="section">
            <h2>📌 License</h2>
            <p>📜 This project is open-source and free to use under the MIT License.</p>
        </div>
        
        <div class="section">
            <h2>📌 Author</h2>
            <p>👨‍💻 Your Name - <a href="#">GitHub Profile</a></p>
        </div>
        
        <div class="footer">
            <p>✨ Happy Coding & Enjoy the Game! 🎮</p>
        </div>
    </div>
</body>
</html>