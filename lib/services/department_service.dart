import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';

import 'package:crimyo/constants.dart';
import 'package:crimyo/models/department.dart';
import 'package:crimyo/models/lesson_plan.dart';

class DepartmentService {
  DepartmentService._privateConstructor();

  static final DepartmentService _instance =
      DepartmentService._privateConstructor();

  factory DepartmentService() {
    return _instance;
  }

  Dio _dio = Dio();

  List<Department> getAllDepartments() {
    return <Department>[
      Department(
        name: "BİLGİSAYAR PROGRAMCILIĞI",
        url:
        "https://cide.kastamonu.edu.tr/index.php/tr/bilgisayar-programciligi",
        imageProvider: AssetImage("assets/images/lesson_1.png"),
      ),
      Department(
        name: "ÇOCUK GELİŞİMİ",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/cocuk-gelisimi",
        imageProvider: AssetImage("assets/images/lesson_2.png"),
      ),
      Department(
        name: "ELEKTRONİK TEKNOLOJİSİ",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/elektronik-teknolojisi",
        imageProvider: AssetImage("assets/images/lesson_3.png"),
      ),
      Department(
        name: "ADALET",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/adalet",
        imageProvider: AssetImage("assets/images/lesson_4.png"),
      ),
      Department(
        name: "KAYNAK TEKNOLOJİSİ",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/kaynak-teknolojisi",
        imageProvider: AssetImage("assets/images/lesson_5.png"),
      ),
      Department(
        name: "MUHASEBE VE VERGİ UYGULAMALARI",
        url:
        "https://cide.kastamonu.edu.tr/index.php/tr/muhasebe-ve-vergi-uygulamalari",
        imageProvider: AssetImage("assets/images/lesson_6.png"),
      ),
      Department(
        name: "TURİZM VE OTEL İŞLETMECİLİĞİ",
        url:
        "https://cide.kastamonu.edu.tr/index.php/tr/turizm-ve-otel-isletmeciligi",
        imageProvider: AssetImage("assets/images/lesson_7.png"),
      ),
    ];
  }

  Future<List<LessonPlan>> getLessonPlanTables(Department department) async {
    String lessonPlanTablePageUrl = department.url;
    if (!lessonPlanTablePageUrl.contains('/ders-programi')){
      lessonPlanTablePageUrl += '/ders-programi';
    }

    try {
      var response = await _dio.get(lessonPlanTablePageUrl);
      if (response.statusCode == 200) {
        var document = parse(response.data);
        var articleContent = document.querySelector(".article-content");
        var titles = articleContent.querySelectorAll("h3");
        var documents = articleContent.querySelectorAll("div embed");

        List<LessonPlan> tables = List();

        for (var i = 0; i < titles.length; i++) {
          var lessonPlan = LessonPlan(
            title: titles[i].text,
            url: baseUrl+documents[i].attributes['src'],
            department: department,
          );
          tables.add(lessonPlan);
        }

        return tables;
      } else {
        return Future.error('statusCodeError');
      }
    } catch (e) {
      return Future.error('undefinedError');
    }
  }
}
