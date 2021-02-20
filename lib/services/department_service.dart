import 'package:dio/dio.dart';
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
      ),
      Department(
        name: "ÇOCUK GELİŞİMİ",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/cocuk-gelisimi",
      ),
      Department(
        name: "ELEKTRONİK TEKNOLOJİSİ",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/elektronik-teknolojisi",
      ),
      Department(
        name: "ADALET",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/adalet",
      ),
      Department(
        name: "KAYNAK TEKNOLOJİSİ",
        url: "https://cide.kastamonu.edu.tr/index.php/tr/kaynak-teknolojisi",
      ),
      Department(
        name: "MUHASEBE VE VERGİ UYGULAMALARI",
        url:
        "https://cide.kastamonu.edu.tr/index.php/tr/muhasebe-ve-vergi-uygulamalari",
      ),
      Department(
        name: "TURİZM VE OTEL İŞLETMECİLİĞİ",
        url:
        "https://cide.kastamonu.edu.tr/index.php/tr/turizm-ve-otel-isletmeciligi",
      ),
    ];
  }

  Future<List<LessonPlan>> getLessonPlanTables(Department department) async {
    String lessonPlanTablePageUrl = '${department.url}/ders-programi';

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
