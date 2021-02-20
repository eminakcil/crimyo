import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';

import 'package:crimyo/components/list_item.dart';
import 'package:crimyo/models/department.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/services/department_service.dart';
import 'package:crimyo/services/navigation_service.dart';

class DepartmentLessonPlanListScreen extends StatelessWidget {
  const DepartmentLessonPlanListScreen({
    @required this.department,
  });

  final Department department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            EnhancedFutureBuilder(
              future: DepartmentService().getLessonPlanTables(department),
              rememberFutureResult: true,
              whenDone: (snapshotData) {
                return ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListItem(
                      text: snapshotData[index].title,
                      press: () {
                        NavigationService().navigatorKey.currentState.push(
                          MaterialPageRoute(
                            builder: (context) => DocumentScreen(
                              url: snapshotData[index].url,
                            ),
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
              whenNotDone: Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              whenError: (error) => Expanded(
                child: Center(
                  child: Icon(
                    Icons.error,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
