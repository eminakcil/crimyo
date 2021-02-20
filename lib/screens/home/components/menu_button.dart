import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    @required this.text,
    this.icon,
    this.iconSize: 24.0,
    this.iconColor: kTextColor,
    this.color: kPrimaryColor,
    this.textColor: kTextColor,
    @required this.press,
    this.buttonHeight: 74.0,
  });

  final String text;
  final IconData icon;
  final double iconSize;
  final double buttonHeight;
  final Color iconColor;
  final Color color;
  final Color textColor;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          height: buttonHeight,
          onPressed: press,
          color: color,
          textColor: textColor,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ),
        SizedBox(height: 8.0),
        Text(text),
      ],
    );
  }
}
