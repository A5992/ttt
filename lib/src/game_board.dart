import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'point.dart';
import 'package:lottie/lottie.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  Gameboardstate createState() => Gameboardstate();
}

class Gameboardstate extends State<GameBoard> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initBoard();
  }

  void _initBoard() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _initBoard();
    });
  }

  void _play(int x, int y) {
    if (_gameOver || _board[x][y] != '') return;

    setState(() {
      _board[x][y] = _currentPlayer;
      _checkGameOver(x, y);
      if (!_gameOver) {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  void _checkGameOver(int x, int y) {
    checkLine(List<Point> line) =>
        line.every((p) => _board[p.x][p.y] == _currentPlayer);
    final linesToCheck = [
      [Point(x, 0), Point(x, 1), Point(x, 2)],
      [Point(0, y), Point(1, y), Point(2, y)],
      if (x == y) [Point(0, 0), Point(1, 1), Point(2, 2)],
      if (x == 2 - y) [Point(0, 2), Point(1, 1), Point(2, 0)],
    ];

    if (linesToCheck.any(checkLine)) {
      _gameOver = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Player $_currentPlayer won!'),
              SizedBox(height: 20),
              _currentPlayer == 'X'
                  ? Lottie.asset('assets/images/red.json',
                      width: 150, height: 150)
                  : Lottie.asset('assets/images/blue.json',
                      width: 150, height: 150),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      );
    } else if (_board.every((row) => row.every((cell) => cell != ''))) {
      _gameOver = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Game Over'),
          content: const Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  "Player $_currentPlayer's turn",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final x = index % 3;
                      final y = index ~/ 3;
                      return buildCell(x, y);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCell(int x, int y) {
    return Animator<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context, animatorState, child) => Transform.scale(
        scale: animatorState.value,
        child: child,
      ),
      child: InkWell(
        onTap: () => _play(x, y),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 250, 177, 148),
                Color.fromARGB(255, 247, 218, 72),
              ],
            ),
          ),
          child: Center(
            child: Text(
              _board[x][y],
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _board[x][y] == 'X' ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
