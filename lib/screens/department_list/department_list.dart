import 'package:flutter/material.dart';

import 'package:crimyo/screens/department_lesson_plan_list/department_lesson_plan_list.dart';
import 'package:crimyo/components/list_item.dart';
import 'package:crimyo/models/department.dart';
import 'package:crimyo/services/department_service.dart';
import 'package:crimyo/services/navigation_service.dart';

class DepartmentList extends StatelessWidget {
  final List<Department> departments = DepartmentService().getAllDepartments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders Programları"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListItem(
                    text: departments[index].name,
                    press: () {
                      NavigationService.push(
                        child: DepartmentLessonPlanListScreen(
                          department: departments[index],
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
                itemCount: departments.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
