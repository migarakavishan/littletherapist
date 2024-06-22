import 'package:flutter/material.dart';
import 'package:littletherapist/models/game_model.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key, required this.gameTitle});

  final GameModel gameTitle;

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const BackButton(),
              Text(
                widget.gameTitle.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: widget.gameTitle.eachGames.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      CustomNavigation.nextPage(
                          context, widget.gameTitle.eachGames[index].widget);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.gameTitle.eachGames[index].name),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    )));
  }
}
