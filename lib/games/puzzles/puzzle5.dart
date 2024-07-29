import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:littletherapist/models/datamodel_puzzle.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:littletherapist/providers/puzzle_score_provider.dart';
import 'package:littletherapist/screens/home_page/home_page.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Puzzle5 extends StatefulWidget {
  const Puzzle5({super.key});

  @override
  State<Puzzle5> createState() => _Puzzle5State();
}

class _Puzzle5State extends State<Puzzle5> {
  List<DatamodelPuzzle> dataModel = [];
  List<DatamodelPuzzle> dataModel2 = [];
  int rows = 4, columns = 4;
  int _start = 60;
  late Timer _timer;
  double _progress = 1.0;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
          _progress = _start / 60.0; // Update progress based on remaining time
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void showCompletionDialog() {
    final score =
        Provider.of<PuzzleScoreProvider>(context, listen: false).score;
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "You've completed all puzzles!\nYour final score is: $score",
        confirmBtnText: 'Home',
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () {
          Navigator.of(context).pop(); // Close the alert
          WidgetsBinding.instance.addPostFrameCallback((_) {
            saveScore(score);
            navigateHome(); // Ensure this is called after the alert is closed
          }); // Navigate home or to any other screen
        });
  }

  void saveScore(int score) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user == null) {
      Logger().e('Error: No user signed in!');
      return;
    }

    final userId = authProvider
        .user?.uid; // Get user ID from the authenticated Firebase user
    FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'score.puzzleScore': score,
    }).then((_) {
      Logger().e('Score updated successfully!');
    }).catchError((error) {
      Logger().e('Failed to update score: $error');
    });
  }

  void navigateHome() {
    CustomNavigation.nextPage(context, const HomePage());
  }

  void completePuzzle() {
    if (_start > 0) {
      Provider.of<PuzzleScoreProvider>(context, listen: false).addScore(20);
    }
    _timer.cancel();
    showCompletionDialog();
  }

  void _incrementCounter() {
    for (var i = 1; i <= rows * columns; i++) {
      dataModel.add(DatamodelPuzzle(
        text: 'Image',
        number: i,
        imagePath: 'assets/images/puzzle5/image_$i.png',
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
                  width: 80,
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/animals2.png"))),
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
                    child: Draggable<DatamodelPuzzle>(
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
                showCompletionDialog();
              },
              child: const CircleAvatar(
                child: Icon(Icons.arrow_right_alt_rounded),
              ),
            )
            // Removed the GestureDetector that was navigating to the same page
          ],
        ),
      ),
    );
  }
}
