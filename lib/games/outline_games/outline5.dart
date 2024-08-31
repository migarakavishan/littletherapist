import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:littletherapist/providers/outline_score_provider.dart';
import 'package:littletherapist/screens/home_page/home_page.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Outline5 extends StatefulWidget {
  const Outline5({super.key});

  @override
  State<Outline5> createState() => _Outline5State();
}

class _Outline5State extends State<Outline5> {
  bool isGirafDropped = false;
  bool isTigerDropped = false;
  bool isElephantDropped = false;
  bool isBirdDropped = false;

  late Timer _timer;
  int _start = 60;
  double _progress = 1.0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
          _progress = _start / 60.0;
        } else {
          _timer.cancel();
          if (isGirafDropped &&
              isTigerDropped &&
              isElephantDropped &&
              isBirdDropped) {
            completeOutline();
          } else {
            // Handle what happens if the time runs out without both items correctly placed
          }
        }
      });
    });
  }

  void showCompletionDialog() {
    final score =
        Provider.of<OutlineScoreProvider>(context, listen: false).score;
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "You've completed all Outlines!\nYour final score is: $score",
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
      'score.outliningScore': score,
    }).then((_) {
      Logger().e('Score updated successfully!');
    }).catchError((error) {
      Logger().e('Failed to update score: $error');
    });
  }

  void navigateHome() {
    CustomNavigation.nextPage(context, const HomePage());
  }

  void completeOutline() {
    if (_start > 0) {
      Provider.of<OutlineScoreProvider>(context, listen: false).addScore(20);
    }
    _timer.cancel();
    showCompletionDialog();
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
          "Drag and drop to correct shadow",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Text(
                    "Level 5",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                              '${Provider.of<OutlineScoreProvider>(context).score}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
                height: 350,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DragTarget(
                            onWillAccept: (data) => data == "bird",
                            onAccept: (data) {
                              setState(() {
                                isBirdDropped = true;
                                if (isBirdDropped &&
                                    isElephantDropped &&
                                    isGirafDropped &&
                                    isTigerDropped) {
                                  completeOutline();
                                }
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return isBirdDropped
                                  ? Image.asset(
                                      "assets/images/bird.png",
                                      height: 120,
                                    )
                                  : Image.asset(
                                      "assets/images/birddark.png",
                                      height: 120,
                                    );
                            }),
                        DragTarget(
                            onWillAccept: (data) => data == "elephant",
                            onAccept: (data) {
                              setState(() {
                                isElephantDropped = true;
                                if (isBirdDropped &&
                                    isElephantDropped &&
                                    isGirafDropped &&
                                    isTigerDropped) {
                                  completeOutline();
                                }
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return isElephantDropped
                                  ? Image.asset(
                                      "assets/images/elephant.png",
                                      height: 120,
                                    )
                                  : Image.asset(
                                      "assets/images/elephantdark.png",
                                      height: 120,
                                    );
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DragTarget(
                            onWillAccept: (data) => data == "tiger",
                            onAccept: (data) {
                              setState(() {
                                isTigerDropped = true;
                                if (isBirdDropped &&
                                    isElephantDropped &&
                                    isGirafDropped &&
                                    isTigerDropped) {
                                  completeOutline();
                                }
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return isTigerDropped
                                  ? Image.asset(
                                      "assets/images/tiger.png",
                                      height: 120,
                                    )
                                  : Image.asset(
                                      "assets/images/tigerdark.png",
                                      height: 120,
                                    );
                            }),
                        DragTarget(
                            onWillAccept: (data) => data == "giraf",
                            onAccept: (data) {
                              setState(() {
                                isGirafDropped = true;

                                if (isBirdDropped &&
                                    isElephantDropped &&
                                    isGirafDropped &&
                                    isTigerDropped) {
                                  completeOutline();
                                }
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return isGirafDropped
                                  ? Image.asset(
                                      "assets/images/giraf2.png",
                                      height: 120,
                                    )
                                  : Image.asset(
                                      "assets/images/giraf2dark.png",
                                      height: 120,
                                    );
                            })
                      ],
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 250,
                decoration: const BoxDecoration(color: Color(0xFFFFA7A7)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Draggable<String>(
                            data: "elephant",
                            feedback: Image.asset(
                              "assets/images/elephant.png",
                              width: 90,
                              opacity: const AlwaysStoppedAnimation(0.5),
                            ),
                            childWhenDragging: Container(width: 90),
                            child: Image.asset(
                              "assets/images/elephant.png",
                              height: 90,
                            )),
                        Draggable<String>(
                            data: "giraf",
                            feedback: Image.asset(
                              "assets/images/giraf2.png",
                              width: 100,
                              opacity: const AlwaysStoppedAnimation(0.5),
                            ),
                            childWhenDragging: Container(width: 90),
                            child: Image.asset(
                              "assets/images/giraf2.png",
                              height: 100,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Draggable<String>(
                            data: "bird",
                            feedback: Image.asset(
                              "assets/images/bird.png",
                              width: 100,
                              opacity: const AlwaysStoppedAnimation(0.5),
                            ),
                            childWhenDragging: Container(
                              width: 90,
                            ),
                            child: Image.asset(
                              "assets/images/bird.png",
                              height: 90,
                            )),
                        Draggable<String>(
                            data: "tiger",
                            feedback: Image.asset(
                              "assets/images/tiger.png",
                              width: 100,
                              opacity: const AlwaysStoppedAnimation(0.5),
                            ),
                            childWhenDragging: Container(width: 90),
                            child: Image.asset(
                              "assets/images/tiger.png",
                              height: 90,
                            )),
                      ],
                    )
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showCompletionDialog();
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
