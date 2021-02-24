import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:crimyo/screens/photo_gallery/photo_gallery_screen.dart';
import 'package:crimyo/constants.dart';
import 'package:crimyo/services/navigation_service.dart';

class ImageRow extends StatelessWidget {
  final List<String> images;

  const ImageRow({
    @required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: kDefaultPadding),
          SingleChildScrollView(
            primary: false,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                images.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      NavigationService.push(
                        builder: (context) => PhotoGalleryScreen(
                          imageUrls: images,
                          initialPage: index,
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(
                        right: index + 1 != images.length ? 20 : 0,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: kDefaultPadding),
        ],
      ),
    );
  }
}
