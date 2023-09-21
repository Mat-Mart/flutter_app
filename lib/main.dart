import 'package:flutter/material.dart';

void main() => runApp(MorpionApp());

class MorpionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morpion',
      home: MorpionGame(),
    );
  }
}

class MorpionGame extends StatefulWidget {
  @override
  _MorpionGameState createState() => _MorpionGameState();
}

class _MorpionGameState extends State<MorpionGame> {
  late List<List<String>> board;
  late String currentPlayer;
  String? winner;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    board = List.generate(3, (_) => List.generate(3, (_) => ''));
    currentPlayer = 'X';
    winner = null;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner == null) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWin(row, col)) {
          winner = currentPlayer;
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWin(int row, int col) {
    // Vérifier les lignes horizontales
    for (int i = 0; i < 3; i++) {
      if (board[i][col] != currentPlayer) {
        break;
      }
      if (i == 2) {
        return true;
      }
    }

    // Vérifier les lignes verticales
    for (int i = 0; i < 3; i++) {
      if (board[row][i] != currentPlayer) {
        break;
      }
      if (i == 2) {
        return true;
      }
    }

    // Vérifier la diagonale principale
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (board[i][i] != currentPlayer) {
          break;
        }
        if (i == 2) {
          return true;
        }
      }
    }

    // Vérifier la diagonale opposée
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (board[i][2 - i] != currentPlayer) {
          break;
        }
        if (i == 2) {
          return true;
        }
      }
    }

    return false;
  }

  Widget buildSquare(int row, int col) {
    return GestureDetector(
      onTap: () => makeMove(row, col),
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          board[row][col],
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morpion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (winner != null) ? 'Gagnant : $winner' : 'Tour de : $currentPlayer',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Column(
              children: List.generate(3, (row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (col) {
                    return buildSquare(row, col);
                  }),
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  resetGame();
                });
              },
              child: Text('Réinitialiser'),
            ),
          ],
        ),
      ),
    );
  }
}
