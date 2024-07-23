import 'dart:async';

import 'package:flutter/material.dart';
import 'package:littletherapist/games/puzzles/puzzle5.dart';
import 'package:littletherapist/models/datamodel_puzzle.dart';
import 'package:littletherapist/providers/puzzle_score_provider.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';
// Ensure this is properly pathed to your ScoreProvider

class Puzzle4 extends StatefulWidget {
  const Puzzle4({super.key});

  @override
  State<Puzzle4> createState() => _Puzzle4State();
}

class _Puzzle4State extends State<Puzzle4> {
  List<DatamodelPuzzle> dataModel = [];
  List<DatamodelPuzzle> dataModel2 = [];
  int rows = 4, columns = 4;
  int _start = 30; // Timer countdown from 20 seconds
  late Timer _timer;
  double _progress = 1.0;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
          _progress = _start / 20.0; // Update progress based on remaining time
        } else {
          _timer.cancel();
          navigateToNextPuzzle();
        }
      });
    });
  }

  void navigateToNextPuzzle() {
    CustomNavigation2.nextPage2(context, const Puzzle5());
  }

  void completePuzzle() {
    if (_start > 0) {
      Provider.of<PuzzleScoreProvider>(context, listen: false).addScore(20);
    }
    _timer.cancel();
    navigateToNextPuzzle();
  }

  void _incrementCounter() {
    for (var i = 1; i <= rows * columns; i++) {
      dataModel.add(DatamodelPuzzle(
        text: 'Image',
        number: i,
        imagePath: 'assets/images/puzzle4/image_$i.png',
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    for (var model in dataModel) {
      dataModel2.add(DatamodelPuzzle(
        text: model.text,
        number: model.number,
        imagePath: model.imagePath,
      ));
    }
    dataModel2.shuffle();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4CA5C1),
        title: const Text(
          "Complete the Puzzle",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                        strokeWidth: 6,
                      ),
                    ),
                    Text("${_start}s"),
                  ],
                ),
                Container(
                  width: 90,
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/animals.png"))),
                ),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade500,
                          borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10))),
                      child: const Center(
                          child: Text(
                        "Score",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    Container(
                      width: 45,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: const BorderRadiusDirectional.only(
                              topEnd: Radius.circular(10),
                              bottomEnd: Radius.circular(10))),
                      child: Center(
                        child: Text(
                            '${Provider.of<PuzzleScoreProvider>(context).score}',
                            style: const TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataModel.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rows,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemBuilder: (context, index) {
                return Center(
                  child: DragTarget<DatamodelPuzzle>(
                    builder: (BuildContext context, List<Object?> candidateData,
                        List<dynamic> rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            border: dataModel[index].dataModel == null
                                ? Border.all(color: Colors.blue)
                                : null),
                        child: Center(
                          child: dataModel[index].dataModel == null
                              ? Text("${index + 1}")
                              : Image.asset(
                                  dataModel[index].dataModel!.imagePath,
                                  fit: BoxFit.cover,
                                  width: 200,
                                ),
                        ),
                      );
                    },
                    onAccept: (data) {
                      setState(() {
                        if (data.number == dataModel[index].number) {
                          dataModel[index].dataModel = data;
                          dataModel2.remove(data);
                          if (dataModel
                              .every((element) => element.dataModel != null)) {
                            completePuzzle();
                          }
                        }
                      });
                    },
                    onWillAccept: (data) {
                      return data?.number == dataModel[index].number;
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: dataModel2.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LongPressDraggable<DatamodelPuzzle>(
                      data: dataModel2[index],
                      feedback: Material(
                        child: Image.asset(
                          dataModel2[index].imagePath,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      childWhenDragging: Container(),
                      child: Image.asset(
                        dataModel2[index].imagePath,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                CustomNavigation2.nextPage2(context, const Puzzle5());
              },
              child: const CircleAvatar(
                child: Icon(Icons.arrow_right_alt_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
