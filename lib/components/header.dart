import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:crimyo/constants.dart';

class Header extends StatelessWidget {
  const Header({
    this.imageUrl,
    this.text,
  });

  final String imageUrl, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: imageUrl != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: text != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kBackgroundColor,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
