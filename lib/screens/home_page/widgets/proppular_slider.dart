import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PropularSlider extends StatelessWidget {
  const PropularSlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200, autoPlay: true),
      items: [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: size.width,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://img.freepik.com/free-vector/hand-drawn-wildlife-background_23-2149424508.jpg"))),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
