import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:crimyo/constants.dart';

class PhotoGalleryScreen extends StatelessWidget {
  final List<String> imageUrls;
  final int initialPage;

  PhotoGalleryScreen({@required this.imageUrls, this.initialPage: 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PhotoViewGallery.builder(
          backgroundDecoration: BoxDecoration(
            color: kBackgroundColor,
          ),
          itemCount: imageUrls.length,
          pageController: PageController(initialPage: initialPage),
          builder: (context, index) => PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 1,
            initialScale: PhotoViewComputedScale.contained,
            basePosition: Alignment.center,
          ),
        ),
      ),
    );
  }
}
