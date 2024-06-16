import 'package:flutter/material.dart';

import 'widgets/home_header.dart';
import 'widgets/menu_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: MenuDrawer(),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeHeader(),
        ),
      ),
    );
  }
}
