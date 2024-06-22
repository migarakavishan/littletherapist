import 'package:flutter/material.dart';
import 'package:littletherapist/models/game_model.dart';
import 'package:littletherapist/screens/home_page/widgets/games_grid.dart';
import 'package:littletherapist/utils/demo_data.dart';

import 'widgets/home_header.dart';
import 'widgets/menu_drawer.dart';
import 'widgets/proppular_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameModel> gamestitle = DemoData.gamestitle;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(size: size),
                const SizedBox(
                  height: 10,
                ),
                const Row(
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
                Text(
                  "Let's start playing!",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                PropularSlider(size: size),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Play Games",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                GamesGrid(gamestitle: gamestitle)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
