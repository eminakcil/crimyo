import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';

import 'package:crimyo/components/header.dart';
import 'package:crimyo/models/post.dart';
import 'package:crimyo/services/parse_helper.dart';
import 'package:crimyo/services/navigation_service.dart';

import 'components/content.dart';
import 'components/image_row.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({@required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: NavigationService().scaffoldKey = GlobalKey<ScaffoldState>(),
      body: SafeArea(
        child: EnhancedFutureBuilder(
          future: ParseHelper().getPostDetail(post),
          rememberFutureResult: false,
          whenDone: (Post snapshotData) => SingleChildScrollView(
            primary: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  imageUrl: snapshotData.images.length > 0
                      ? snapshotData.images[0]
                      : null,
                  text: snapshotData.title,
                ),
                Content(text: snapshotData.content),
                if (snapshotData.images.length > 0)
                  ImageRow(images: snapshotData.images),
              ],
            ),
          ),
          whenNotDone: Center(
            child: CircularProgressIndicator(),
          ),
          whenError: (error) => Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
