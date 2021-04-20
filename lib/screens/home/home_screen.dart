import 'package:crimyo/screens/home/components/image_slider.dart';
import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

import 'components/home_buttons.dart';

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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Column(
              children: [
                ImageSlider(),
                SizedBox(height: kDefaultPadding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: HomeButtons(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
