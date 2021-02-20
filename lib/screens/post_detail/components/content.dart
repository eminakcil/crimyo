import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

class Content extends StatelessWidget {
  final String text;

  const Content({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        kDefaultPadding,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}
