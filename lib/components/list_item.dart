import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    @required this.text,
    @required this.press,
  });

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
          vertical: kDefaultPadding,
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
