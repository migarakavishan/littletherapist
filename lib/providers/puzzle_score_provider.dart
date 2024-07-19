import 'package:flutter/cupertino.dart';

class PuzzleScoreProvider extends ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void addScore(int points) {
    _score += points;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}
