import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';

import 'package:crimyo/models/post.dart';
import 'package:crimyo/components/list_item.dart';
import 'package:crimyo/screens/post_detail/post_detail_screen.dart';
import 'package:crimyo/services/navigation_service.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({
    @required this.postListFuture,
  });

  final Future<List<Post>> postListFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EnhancedFutureBuilder(
          future: postListFuture,
          rememberFutureResult: false,
          whenDone: (snapshotData) => ListView.separated(
            itemBuilder: (context, index) {
              return ListItem(
                text: snapshotData[index].title,
                press: () {
                  NavigationService.push(
                    builder: (context) => PostDetailScreen(
                      post: snapshotData[index],
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 0,
              );
            },
            itemCount: snapshotData.length,
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
