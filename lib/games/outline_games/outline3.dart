import 'dart:async';

import 'package:flutter/material.dart';
import 'package:littletherapist/games/outline_games/outline2.dart';
import 'package:littletherapist/providers/outline_score_provider.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class Outline3 extends StatefulWidget {
  const Outline3({super.key});

  @override
  State<Outline3> createState() => _Outline3State();
}

class _Outline3State extends State<Outline3> {
  bool isDropped = false;

  late Timer _timer;
  int _start = 60;
  double _progress = 1.0;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
          _progress = _start / 60.0;
        } else {
          _timer.cancel();
          if (!isDropped) {
            // If not dropped correctly till timer expiry
            // Optionally show a timeout dialog
          }
        }
      });
    });
  }

  void navigateToNextOutline() {
    CustomNavigation2.nextPage2(context, const Outline3());
  }

  void completeOutline() {
    if (_start > 0 && !isDropped) {
      // Check if timer is still running and puzzle not already completed
      isDropped = true;
      Provider.of<OutlineScoreProvider>(context, listen: false).addScore(20);
      _timer.cancel(); // Stop the timer
      navigateToNextOutline(); // Move to next outline
      setState(() {}); // Update the UI
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the game timer when the screen loads
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      "Level 3",
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
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/playground.png'))),
                child: Stack(
                  children: [
                    Positioned(
                        top: 110,
                        left: 150,
                        child: DragTarget<String>(
                          onAcceptWithDetails: (data) {
                            setState(() {
                              isDropped = true;
                            });
                          },
                          builder: (context, candidateData, rejectedData) {
                            return isDropped
                                ? Image.asset(
                                    "assets/images/girl.png",
                                    height: 150,
                                  )
                                : Image.asset(
                                    "assets/images/girlwhite.png",
                                    height: 150,
                                  );
                          },
                        ))
                  ],
                ),
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(color: Colors.purpleAccent),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 70,
                        left: 140,
                        child: Draggable<String>(
                            data: "girl",
                            feedback: Image.asset(
                              "assets/images/girl.png",
                              height: 150,
                              opacity: const AlwaysStoppedAnimation(0.5),
                            ),
                            childWhenDragging: Container(),
                            child: Image.asset(
                              "assets/images/girl.png",
                              height: 150,
                            )))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  CustomNavigation2.nextPage2(context, const Outline2());
                },
                child: const CircleAvatar(
                  child: Icon(Icons.arrow_right_alt_rounded),
                ),
              )
            ],
          ),
        ));
  }
}
