import 'package:crimyo/screens/home/components/image_slider.dart';
import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

import 'components/buttons_grid_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Cide Rıfat Ilgaz Meslek Yüksekokulu")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: kDefaultPadding),
              ImageSlider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: ButtonsGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
