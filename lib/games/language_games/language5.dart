import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:littletherapist/providers/language_score_provider.dart';
import 'package:littletherapist/screens/home_page/home_page.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Language5 extends StatefulWidget {
  const Language5({super.key});

  @override
  State<Language5> createState() => _Language5State();
}

class _Language5State extends State<Language5>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  String message = "";

  bool scoreAdded = false; // State variable to track if score has been added

  @override
  void initState() {
    super.initState();
    initTTS();
    speak("Is this a boy?");

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
      speak("Correct! Well done! Yes This is a boy.");
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

  void showCompletionDialog() {
    final score =
        Provider.of<LanguageScoreProvider>(context, listen: false).score;
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
      'score.languageScore': score,
    }).then((_) {
      Logger().e('Score updated successfully!');
    }).catchError((error) {
      Logger().e('Failed to update score: $error');
    });
  }

  void navigateHome() {
    CustomNavigation.nextPage(context, const HomePage());
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
                      "Is this a boy?",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 20),
                    ScaleTransition(
                      scale: _animationController
                          .drive(Tween(begin: 1.0, end: 1.2)),
                      child: Image.asset("assets/images/boy.png",
                          width: 300, height: 200),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            handleResponse(true);
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
                            handleResponse(false);
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
                            onPressed: () => speak("Is this a boy?"),
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
                  showCompletionDialog();
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
