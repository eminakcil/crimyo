import 'package:flutter/material.dart';

class Department {
  String name, url;
  ImageProvider imageProvider;

  Department({
    @required this.name,
    @required this.url,
    this.imageProvider,
  });

}