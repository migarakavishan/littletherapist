import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:littletherapist/providers/signin_provider.dart';
import 'package:littletherapist/screens/auth_screen/forgot_password/forgot_password.dart';
import 'package:littletherapist/screens/auth_screen/register_screen/register_screen.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            child: Consumer<SigninProvider>(builder: (context, value, child) {
              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.001,
                  ),
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(curve: Curves.easeIn),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                    controller: value.emailController,
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
                    controller: value.passwordController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                              text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            CustomNavigation.nextPage(
                                context, const ForgotPassword());
                          },
                        text: "Forgot Password?",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 15),
                      ))
                          .animate()
                          .fade(duration: 500.ms)
                          .slideY(curve: Curves.easeIn)
                    ],
                  ),
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
                            value.startSignUp();
                          },
                          child: const Text(
                            "Login",
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
                              text: "I havn't an account.",
                              style: const TextStyle(
                                  color: Colors.purple, fontSize: 15),
                              children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                CustomNavigation.nextPage(
                                    context, const RegisterScreen());
                              },
                            text: "Sign up",
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
                            image: AssetImage("assets/images/cutecat.png"))),
                  ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0)
                ],
              );
            }),
          ),
        ),
      )),
    );
  }
}
