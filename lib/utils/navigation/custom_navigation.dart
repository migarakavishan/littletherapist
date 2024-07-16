import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigation {
  static void nextPage(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

class CustomNavigation2 {
  static void nextPage2(BuildContext context, Widget widget) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => widget));
  }
}