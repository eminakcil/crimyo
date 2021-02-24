import 'package:carousel_slider/carousel_slider.dart';
import 'package:crimyo/constants.dart';
import 'package:flutter/material.dart';

import 'components/buttons_grid_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sliderItems = [
      "assets/images/slider-1.png",
      "assets/images/slider-2.png",
      "assets/images/slider-3.png",
      "assets/images/slider-4.png",
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kDefaultPadding),
              CarouselSlider(
                items: sliderItems.map((e) {
                  return Image(
                    image: AssetImage(e),
                    fit: BoxFit.cover,
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                child: ButtonsGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
