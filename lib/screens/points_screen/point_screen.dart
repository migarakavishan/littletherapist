import 'package:flutter/material.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({super.key});

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  String getFeedback(int score) {
    if (score > 70) {
      return "Excellent";
    } else if (score > 30) {
      return "Good, keep it up!";
    } else {
      return "Improve more";
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<AuthProvider>(context).userModel!;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey.shade600,
        title: const Text(
          "My Points",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userModel.image),
            ),
            Text(
              userModel.name,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 400,
              width: 380,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Puzzle Games",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Selector<AuthProvider, int>(
                      selector: (context, provider) =>
                          provider.userModel!.puzzleScore,
                      builder: (context, puzzleScore, __) {
                        String feedbackText = getFeedback(puzzleScore);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LinearPercentIndicator(
                              width: 230,
                              lineHeight: 20,
                              animationDuration: 500,
                              animation: true,
                              percent: puzzleScore / 100.0,
                              center: Text(
                                "${((puzzleScore / 100.0) * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                              barRadius: const Radius.circular(20),
                            ),
                            Text(
                              feedbackText,
                              style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 30),
                  const Text(
                    "Outline Games",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Selector<AuthProvider, int>(
                      selector: (context, provider) =>
                          provider.userModel!.outliningScore,
                      builder: (context, outliningScore, __) {
                        String feedbackText = getFeedback(outliningScore);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LinearPercentIndicator(
                              width: 230,
                              lineHeight: 20,
                              animationDuration: 500,
                              animation: true,
                              percent: outliningScore / 100.0,
                              center: Text(
                                "${((outliningScore / 100.0) * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                              barRadius: const Radius.circular(20),
                            ),
                            Text(
                              feedbackText,
                              style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 30),
                  const Text(
                    "Language Games",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Selector<AuthProvider, int>(
                      selector: (context, provider) =>
                          provider.userModel!.languageScore,
                      builder: (context, languageScore, __) {
                        String feedbackText = getFeedback(languageScore);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LinearPercentIndicator(
                              width: 230,
                              lineHeight: 20,
                              animationDuration: 500,
                              animation: true,
                              percent: languageScore / 100.0,
                              center: Text(
                                "${((languageScore / 100.0) * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                              barRadius: const Radius.circular(20),
                            ),
                            Text(
                              feedbackText,
                              style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 30),
                  const Text(
                    "Math Games",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Selector<AuthProvider, int>(
                      selector: (context, provider) =>
                          provider.userModel!.mathScore,
                      builder: (context, mathScore, __) {
                        String feedbackText = getFeedback(mathScore);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LinearPercentIndicator(
                              width: 230,
                              lineHeight: 20,
                              animationDuration: 500,
                              animation: true,
                              percent: mathScore / 100.0,
                              center: Text(
                                "${((mathScore / 100.0) * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                              barRadius: const Radius.circular(20),
                            ),
                            Text(
                              feedbackText,
                              style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
