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
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(size: size),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Peter",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Let's start playing!",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  ),
                ),
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
