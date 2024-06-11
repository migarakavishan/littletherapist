import 'package:flutter/material.dart';

class CustomNavigation {
  static void nextPage(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
