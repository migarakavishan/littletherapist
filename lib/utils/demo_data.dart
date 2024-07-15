import 'package:littletherapist/games/outline_games/outline1.dart';
import 'package:littletherapist/games/outline_games/outline2.dart';
import 'package:littletherapist/games/puzzles/puzzle1.dart';
import 'package:littletherapist/games/puzzles/puzzle2.dart';
import 'package:littletherapist/games/puzzles/puzzle3.dart';
import 'package:littletherapist/models/game_model.dart';
import 'package:littletherapist/models/outline_games_model.dart';
import 'package:littletherapist/models/puzzle_model.dart';

class DemoData {
  static List<GameModel> gamestitle = [
    GameModel(
        id: 1,
        title: 'Outline Games',
        logo: 'assets/images/outlinegames.png',
        eachGames: DemoData.outlinegamesmodel),
    GameModel(
        id: 2,
        title: 'Puzzles',
        logo: 'assets/images/puzzles.png',
        eachGames: DemoData.puzzlemodel),
    GameModel(
        id: 3,
        title: 'Learn Words',
        logo: 'assets/images/learnwords.png',
        eachGames: DemoData.outlinegamesmodel),
    GameModel(
        id: 4,
        title: 'Math Games',
        logo: 'assets/images/mathgames.png',
        eachGames: DemoData.outlinegamesmodel),
  ];

  static List<OutlineGamesModel> outlinegamesmodel = [
    OutlineGamesModel(id: 1, name: 'Level 1', widget: const Outline1()),
    OutlineGamesModel(id: 2, name: 'Level 2', widget: const Outline2()),
  ];

  static List<PuzzleModel> puzzlemodel = [
    PuzzleModel(id: 1, name: 'Level 1', widget: const Puzzle1()),
    PuzzleModel(id: 2, name: 'Level 2', widget: const Puzzle2()),
    PuzzleModel(id: 3, name: 'Level 3', widget: const Puzzle3()),
  ];
}
