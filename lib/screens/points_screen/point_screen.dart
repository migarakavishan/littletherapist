import 'package:flutter/material.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:logger/logger.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
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

  void sendStyledEmail(BuildContext context) async {
    final userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel!;
    final smtpServer = gmail('gametomato2@gmail.com',
        'lklo suqi exxm salf'); // Replace with your actual email and password

    // URL of the logo
    const String logoUrl =
        'https://drive.google.com/drive/u/0/folders/15jHWhN3Vd8JFhJN9K5fRxoNAQEAQtrNU'; // Replace with your actual image URL

    final String htmlContent = '''
<html>
  <head>
    <style>
      body { 
        font-family: Arial, sans-serif;
        background-image: url('https://img.freepik.com/free-vector/futuristic-technological-wallpaper_79603-1093.jpg?semt=ais_hybrid'); /* Add your background image URL here */
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center center;
      }
      .header { 
        background: #f3f3f3; 
        padding: 20px; 
        text-align: center; 
      }
      .content { 
        margin: 20px; 
        text-align: left; 
        font-size: 16px; 
        background-color: rgba(255, 255, 255, 0.8); /* Slight white background for readability */
        border-radius: 10px;
        padding: 20px;
      }
      .footer { 
        padding: 20px; 
        text-align: center; 
        color: #aaa; 
      }
    </style>
  </head>
  <body>
    <div class="header">
      <img src="$logoUrl" alt="Logo" width="100" height="50">
      <h1>Your Points Summary</h1>
    </div>
    <div class="content">
      <p>Here are your game points:</p>
      <ul>
        <li>Puzzle Games: ${userModel.puzzleScore}</li>
        <li>Outline Games: ${userModel.outliningScore}</li>
        <li>Language Games: ${userModel.languageScore}</li>
        <li>Math Games: ${userModel.mathScore}</li>
      </ul>
    </div>
    <div class="footer">
      <p>Thank you for using Little Therapist!</p>
    </div>
  </body>
</html>

''';

    final message = Message()
      ..from = const Address('gametomato2@gmail.com', 'Little Theraphist')
      ..recipients.add(userModel.email) // Recipient's email
      ..subject = 'Your Points Summary'
      ..html = htmlContent;

    try {
      final sendReport = await send(message, smtpServer);
      Logger().e('Message sent: $sendReport');
    } catch (e) {
      Logger().e('Message not sent.');
      Logger().e(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<AuthProvider>(context).userModel!;
    final size = MediaQuery.sizeOf(context);
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
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                    minimumSize:
                        WidgetStatePropertyAll(Size(size.width * 0.7, 50))),
                onPressed: () {
                  sendStyledEmail(context);
                },
                child: const Text(
                  "Send My Points Via Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
