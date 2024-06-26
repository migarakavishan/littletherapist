import 'package:flutter/material.dart';
import 'package:littletherapist/models/game_model.dart';
import 'package:littletherapist/screens/level_screen/level_screen.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class GamesGrid extends StatelessWidget {
  const GamesGrid({super.key, required this.gamestitle});

  final List<GameModel> gamestitle;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gamestitle.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            CustomNavigation.nextPage(
                context,
                LevelScreen(
                  gameTitle: gamestitle[index],
                ));
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: const Color(0xFF4CA5C1),
                image:
                    DecorationImage(image: AssetImage(gamestitle[index].logo)),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gamestitle[index].title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
