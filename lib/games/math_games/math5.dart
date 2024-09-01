import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:littletherapist/providers/math_score_provide.dart';
import 'package:littletherapist/screens/home_page/home_page.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Math5 extends StatefulWidget {
  const Math5({super.key});

  @override
  State<Math5> createState() => _Math5State();
}

class _Math5State extends State<Math5> {
  bool isNum7Dropped = false;

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

          if (isNum7Dropped) {
            completeMath();
          } else {
            // Handle what happens if the time runs out without both items correctly placed
          }
        }
      });
    });
  }

  void showCompletionDialog() {
    final score = Provider.of<MathScoreProvider>(context, listen: false).score;
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "You've completed all Maths!\nYour final score is: $score",
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
      'score.mathScore': score,
    }).then((_) {
      Logger().e('Score updated successfully!');
    }).catchError((error) {
      Logger().e('Failed to update score: $error');
    });
  }

  void navigateHome() {
    CustomNavigation.nextPage(context, const HomePage());
  }

  void completeMath() {
    if (_start > 0) {
      Provider.of<MathScoreProvider>(context, listen: false).addScore(20);
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
          "Give Correct Ansewer",
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
                              '${Provider.of<MathScoreProvider>(context).score}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 500,
              height: 450,
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "+",
                          style: TextStyle(fontSize: 80, color: Colors.white),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                  Image.asset(
                                    "assets/images/appleright.png",
                                    height: 60,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "=",
                        style: TextStyle(fontSize: 80, color: Colors.white),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: DragTarget<String>(
                      onWillAccept: (data) => data == "number7",
                      onAccept: (data) {
                        setState(() {
                          isNum7Dropped = true;
                          completeMath();
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return isNum7Dropped
                            ? Image.asset(
                                "assets/images/number7.png",
                                height: 100,
                              )
                            : const SizedBox(
                                height: 90,
                                width: 90,
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable<String>(
                      data: "number7",
                      feedback: Image.asset(
                        "assets/images/number7.png",
                        height: 90,
                        width: 90,
                        opacity: const AlwaysStoppedAnimation(0.5),
                      ),
                      childWhenDragging: const SizedBox(
                        height: 90,
                        width: 90,
                      ),
                      child: Image.asset(
                        "assets/images/number7.png",
                        height: 90,
                        width: 90,
                      )),
                  Draggable<String>(
                      data: "number4",
                      feedback: Image.asset(
                        "assets/images/number4.png",
                        height: 90,
                        width: 90,
                        opacity: const AlwaysStoppedAnimation(0.5),
                      ),
                      childWhenDragging: const SizedBox(
                        height: 90,
                        width: 90,
                      ),
                      child: Image.asset(
                        "assets/images/number4.png",
                        height: 90,
                        width: 90,
                      )),
                  Draggable<String>(
                      data: "number5",
                      feedback: Image.asset(
                        "assets/images/number5.png",
                        height: 90,
                        width: 90,
                        opacity: const AlwaysStoppedAnimation(0.5),
                      ),
                      childWhenDragging: const SizedBox(
                        height: 90,
                        width: 90,
                      ),
                      child: Image.asset(
                        "assets/images/number5.png",
                        height: 90,
                        width: 90,
                      )),
                ],
              ),
            ),
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
