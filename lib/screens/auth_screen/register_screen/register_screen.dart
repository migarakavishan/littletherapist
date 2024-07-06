import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:littletherapist/controllers/auth_controller.dart';
import 'package:littletherapist/screens/auth_screen/login_screen/login_screen.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.001,
                  ),
                  const Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  FilledButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  const WidgetStatePropertyAll(Colors.blue),
                              minimumSize: WidgetStatePropertyAll(
                                  Size(size.width * 1, 50))),
                          onPressed: () {
                            if (emailController.text.trim().isEmpty ||
                                passwordController.text.trim().isEmpty ||
                                passwordController.text !=
                                    confirmPasswordController.text) {
                              Logger().e("Invalid data");
                            } else {
                              AuthController().createAccount(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ))
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RichText(
                          text: TextSpan(
                              text: "I have an account.",
                              style: const TextStyle(
                                  color: Colors.purple, fontSize: 15),
                              children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                CustomNavigation.nextPage(
                                    context, const LoginScreen());
                              },
                            text: "Login",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))
                      ]))
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 0.5,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/whale.png"))),
                  ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
