import 'package:flutter/material.dart';

import 'package:crimyo/components/header.dart';
import 'package:crimyo/services/navigation_service.dart';

import 'components/buttons_grid_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: NavigationService().scaffoldKey = GlobalKey<ScaffoldState>(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(
                imageUrl: "https://cide.kastamonu.edu.tr/images/2018/manset/slider2.png",
                text: "",
              ),
              ButtonsGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
