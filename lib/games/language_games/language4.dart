import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littletherapist/providers/language_score_provider.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class Language4 extends StatefulWidget {
  const Language4({super.key});

  @override
  State<Language4> createState() => _Language4State();
}

class _Language4State extends State<Language4>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  String message = "";

  bool scoreAdded = false; // State variable to track if score has been added

  @override
  void initState() {
    super.initState();
    initTTS();
    speak("Is this a dog?");

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  Future<void> initTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  void handleResponse(bool isCorrect) {
    if (isCorrect) {
      if (!scoreAdded) {
        Provider.of<LanguageScoreProvider>(context, listen: false).addScore(20);
        scoreAdded = true; // Update state to prevent further score addition
      }
      setState(() {
        message = "Correct! 🎉 Well done!";
      });
      speak("Correct! Well done! Yes it is an elephant");
      _animationController
          .forward()
          .then((_) => _animationController.reverse());
    } else {
      setState(() {
        message = "Incorrect, try again.";
      });
      speak("Incorrect, try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Games"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Level 4",
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
                                '${Provider.of<LanguageScoreProvider>(context).score}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Is this a dog?",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 20),
                    ScaleTransition(
                      scale: _animationController
                          .drive(Tween(begin: 1.0, end: 1.2)),
                      child: Image.asset("assets/images/elephant.png",
                          width: 200, height: 200),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            handleResponse(false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          child: const Text("Yes",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            handleResponse(true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          child: const Text("No",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () => speak("What is this?"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            child: const Icon(
                              Icons.replay,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(message,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  CustomNavigation2.nextPage2(context, const Language4());
                },
                child: const CircleAvatar(
                  child: Icon(Icons.arrow_right_alt_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    flutterTts.stop();
    super.dispose();
  }
}
