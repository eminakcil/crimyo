import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';
import 'package:crimyo/components/centered_grid_view.dart';
import 'package:crimyo/models/department.dart';
import 'package:crimyo/services/department_service.dart';

import 'components/department_button.dart';

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
            children: [
              SizedBox(height: kDefaultPadding),
              CenteredGridView(
                crossAxisCount: 3,
                children: departments.map((e) {
                  return DepartmentButton(e);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
