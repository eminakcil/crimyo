import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required this.text,
    @required this.press,
    this.color,
    this.textColor,
    this.radius,
  }) : super(key: key);

  final String text;
  final Color color, textColor;
  final Function press;
  final double radius;

  @override
  Widget build(BuildContext context) {
    Color _color = color ?? kPrimaryColor;
    Color _textColor = textColor ?? Color(0xFFFFFFFF);
    double _radius = radius ?? 20.0;
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
      color: _color,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: _textColor,
        ),
      ),
    );
  }
}