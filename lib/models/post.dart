import 'package:flutter/material.dart';

class Post {
  String title, url, content;
  List<String> images;

  Post({
    this.title,
    @required this.url,
    this.content,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'content': content,
      'images': images,
    };
  }
}
