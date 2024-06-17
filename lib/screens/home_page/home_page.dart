import 'package:flutter/material.dart';

import 'widgets/home_header.dart';
import 'widgets/menu_drawer.dart';
import 'widgets/proppular_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          child: MenuDrawer(),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HomeHeader(size: size),
                const SizedBox(
                  height: 10,
                ),
                PropularSlider(size: size)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
