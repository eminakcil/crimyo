import 'package:flutter/material.dart';

import 'package:crimyo/components/list_item.dart';
import 'package:crimyo/models/department.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/services/department_service.dart';
import 'package:crimyo/services/navigation_service.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';

class LessonPlanList extends StatelessWidget {

  LessonPlanList({@required this.department});

  final Department department;

  @override
  Widget build(BuildContext context) {
    return EnhancedFutureBuilder(
      future: DepartmentService().getLessonPlanTables(department),
      rememberFutureResult: true,
      whenDone: (snapshotData) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListItem(
              text: snapshotData[index].title,
              press: () {
                NavigationService.push(
                  child: DocumentScreen(
                    url: snapshotData[index].url,
                    title: snapshotData[index].title,
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
        );
      },
      whenNotDone: Center(
        child: CircularProgressIndicator(),
      ),
      whenError: (error) => Center(
        child: Icon(
          Icons.error,
        ),
      ),
    );
  }
}
