/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animator/animator.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GameBoard(),
    );
  }
}

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
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
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
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
          content: Text('Player $_currentPlayer won!'),
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
      body: Center(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade200,
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

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
}
*/