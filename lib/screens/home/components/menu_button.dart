import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    @required this.text,
    this.imageUrl,
    this.imageProvider,
    this.color: kPrimaryColor,
    this.textColor: kTextColor,
    @required this.press,
    this.buttonHeight: 74.0,
  });

  final String text;
  final String imageUrl;
  final double buttonHeight;
  final Color color;
  final ImageProvider imageProvider;
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
          child: imageUrl != null
              ? CachedNetworkImage(
                  height: buttonHeight,
                  width: buttonHeight,
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: buttonHeight,
                      height: buttonHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Icon(Icons.error),
                    );
                  },
                )
              : imageProvider != null
                  ? Container(
                      width: buttonHeight,
                      height: buttonHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
          shape: CircleBorder(),
        ),
        SizedBox(height: 8.0),
        Text(text),
      ],
    );
  }
}
