import 'package:crimyo/constants.dart';

import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';

import 'package:crimyo/models/post.dart';
import 'package:crimyo/services/parse_helper.dart';

import 'components/html_view.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({@required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: EnhancedFutureBuilder(
          future: ParseHelper().getContentInnerHtml(post.url),
          rememberFutureResult: false,
          whenDone: (String snapshotData) => Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: HtmlView(snapshotData),
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
