import 'package:flutter/material.dart';
import 'package:littletherapist/screens/auth_screen/register_screen.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class GetStartButton extends StatelessWidget {
  const GetStartButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3))
          ]),
      child: FilledButton(
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.red),
              minimumSize: WidgetStatePropertyAll(
                  Size(size.width * 0.7, size.height * 0.06))),
          onPressed: () {
            CustomNavigation.nextPage(context, const RegisterScreen());
          },
          child: const Text(
            "GET START",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )),
    );
  }
}
