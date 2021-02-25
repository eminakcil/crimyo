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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              LessonPlanList(department: department),
            ],
          ),
        ),
      ),
    );
  }
}
