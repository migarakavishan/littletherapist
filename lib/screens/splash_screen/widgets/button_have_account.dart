import 'package:flutter/material.dart';

class HaveAccountButton extends StatelessWidget {
  const HaveAccountButton({
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
      child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor:
                  const WidgetStatePropertyAll(Colors.white),
              minimumSize: WidgetStatePropertyAll(
                  Size(size.width * 0.7, size.height * 0.06))),
          onPressed: () {},
          child: const Text(
            "ALREADY HAVE ACCOUNT",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
    );
  }
}
