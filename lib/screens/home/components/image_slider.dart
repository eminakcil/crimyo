import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final sliderItems = [
    "assets/images/slider-1.png",
    "assets/images/slider-2.png",
    "assets/images/slider-3.png",
    "assets/images/slider-4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: sliderItems.map((e) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(e),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
    );
  }
}
