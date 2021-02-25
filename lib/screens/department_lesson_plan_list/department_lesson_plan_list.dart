import 'package:flutter/material.dart';

import 'package:crimyo/models/department.dart';

import 'compnents/lesson_plan_list.dart';


class DepartmentLessonPlanListScreen extends StatelessWidget {
  const DepartmentLessonPlanListScreen({
    @required this.department,
  });

  final Department department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(department.name),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LessonPlanList(department: department),
          ],
        ),
      ),
    );
  }
}
