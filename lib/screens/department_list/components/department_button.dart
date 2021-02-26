import 'package:crimyo/screens/department_lesson_plan_list/department_lesson_plan_list.dart';
import 'package:crimyo/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:crimyo/models/department.dart';

import 'package:crimyo/constants.dart';

class DepartmentButton extends StatelessWidget {
  const DepartmentButton(
    this.department,
  );

  final Department department;
  final double buttonHeight = 74.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.push(
          child: DepartmentLessonPlanListScreen(department: department),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: buttonHeight,
            width: buttonHeight,
            decoration: BoxDecoration(
              color: Color(0xFF6495ed),
              borderRadius: BorderRadius.circular(kDefaultPadding),
            ),
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Image(
              image: department.imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            department.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
