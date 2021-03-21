import 'package:crimyo/constants.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';

import 'package:crimyo/components/header.dart';
import 'package:crimyo/models/post.dart';
import 'package:crimyo/services/parse_helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../components/content.dart';
import '../components/image_row.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({@required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EnhancedFutureBuilder(
          future: ParseHelper().getContentInnerHtml(post.url),
          rememberFutureResult: false,
          whenDone: (String snapshotData) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: HtmlWidget(
                snapshotData,
                onTapUrl: (url) {
                  print(url);
                  if (url.contains('.')) {
                    String extension = url.substring(url.lastIndexOf("."));
                    if (extension == '.pdf') {
                      if (url[0] == '/') url = baseUrl + url;
                      NavigationService.push(
                          child: DocumentScreen(url: url));
                    }
                    print(extension);
                  }
                },
                customStylesBuilder: (element) {
                  if (element.attributes['title'] != null)
                    return {
                      'color': '#000',
                      'text-decoration': 'none',
                    };
                  return null;
                },
                customWidgetBuilder: (element) {
                  // Image Row Widget
                  if (element.classes.contains('sigFreeContainer')) {
                    var images = element.querySelectorAll('img');
                    List<String> imageUrlList =
                        images.map((e) => e.attributes['src']).toList();
                    return ImageRow(images: imageUrlList);
                  }
                  return null;
                },
                // webView: true,
              ),
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
