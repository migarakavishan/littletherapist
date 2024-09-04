import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PopularSlider extends StatelessWidget {
  const PopularSlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'assets/images/outlinebanner.webp',
      'assets/images/puzzlebanner.webp',
      'assets/images/languagebanner.webp',
      'assets/images/mathbanner.webp',
    ];

    return CarouselSlider(
      options: CarouselOptions(height: 200, autoPlay: true),
      items: imageList.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: size.width,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
