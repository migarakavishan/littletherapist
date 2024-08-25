import 'package:littletherapist/games/drawing_pad/drawing_pad.dart';
import 'package:littletherapist/games/language_games/language1.dart';
import 'package:littletherapist/games/math_games/math1.dart';
import 'package:littletherapist/games/math_games/math2.dart';
import 'package:littletherapist/games/math_games/math3.dart';
import 'package:littletherapist/games/math_games/math4.dart';
import 'package:littletherapist/games/math_games/math5.dart';
import 'package:littletherapist/games/outline_games/how_to_play_outline.dart';
import 'package:littletherapist/games/outline_games/outline1.dart';
import 'package:littletherapist/games/outline_games/outline2.dart';
import 'package:littletherapist/games/outline_games/outline3.dart';
import 'package:littletherapist/games/outline_games/outline4.dart';
import 'package:littletherapist/games/outline_games/outline5.dart';
import 'package:littletherapist/games/puzzles/how_to_play_puzzle.dart';
import 'package:littletherapist/games/puzzles/puzzle1.dart';
import 'package:littletherapist/games/puzzles/puzzle2.dart';
import 'package:littletherapist/games/puzzles/puzzle3.dart';
import 'package:littletherapist/games/puzzles/puzzle4.dart';
import 'package:littletherapist/games/puzzles/puzzle5.dart';
import 'package:littletherapist/models/drawing_pad_model.dart';
import 'package:littletherapist/models/game_model.dart';
import 'package:littletherapist/models/learn_words_model.dart';
import 'package:littletherapist/models/math_model.dart';
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
        title: 'Language Games',
        logo: 'assets/images/learnwords.png',
        eachGames: DemoData.learnwordsmodel),
    GameModel(
        id: 4,
        title: 'Math Games',
        logo: 'assets/images/mathgames.png',
        eachGames: DemoData.mathmodel),
    GameModel(
        id: 5,
        title: 'Drawing Pad',
        logo: 'assets/images/drawingPad.png',
        eachGames: DemoData.drawingPadmodel),
  ];

  static List<OutlineGamesModel> outlinegamesmodel = [
    OutlineGamesModel(
        id: 0, name: 'How to Play', widget: const HowToPlayOutline()),
    OutlineGamesModel(id: 1, name: 'Level 1', widget: const Outline1()),
    OutlineGamesModel(id: 2, name: 'Level 2', widget: const Outline2()),
    OutlineGamesModel(id: 3, name: 'Level 3', widget: const Outline3()),
    OutlineGamesModel(id: 4, name: 'Level 4', widget: const Outline4()),
    OutlineGamesModel(id: 5, name: 'Level 5', widget: const Outline5()),
  ];

  static List<PuzzleModel> puzzlemodel = [
    PuzzleModel(id: 0, name: 'How to Play', widget: const HowToPlayPuzzle()),
    PuzzleModel(id: 1, name: 'Level 1', widget: const Puzzle1()),
    PuzzleModel(id: 2, name: 'Level 2', widget: const Puzzle2()),
    PuzzleModel(id: 3, name: 'Level 3', widget: const Puzzle3()),
    PuzzleModel(id: 4, name: 'Level 4', widget: const Puzzle4()),
    PuzzleModel(id: 5, name: 'Level 5', widget: const Puzzle5()),
  ];

  static List<MathModel> mathmodel = [
    MathModel(id: 1, name: "Level 1", widget: const Math1()),
    MathModel(id: 2, name: "Level 2", widget: const Math2()),
    MathModel(id: 3, name: "Level 3", widget: const Math3()),
    MathModel(id: 4, name: "Level 4", widget: const Math4()),
    MathModel(id: 5, name: "Level 5", widget: const Math5()),
  ];

  static List<LanguageGamesModel> learnwordsmodel = [
    LanguageGamesModel(id: 1, name: "Level 1", widget: const Language1())
  ];

  static List<DrawingPadModel> drawingPadmodel = [
    DrawingPadModel(id: 1, name: 'drawing pad', widget: const DrawingPad())
  ];
}
