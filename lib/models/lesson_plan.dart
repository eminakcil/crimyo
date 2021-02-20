import 'package:flutter/material.dart';

import 'package:crimyo/models/department.dart';

class LessonPlan {
  const LessonPlan({
    @required this.title,
    @required this.url,
    this.department,
  });

  final String title, url;
  final Department department;
}
