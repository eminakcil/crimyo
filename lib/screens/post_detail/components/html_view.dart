import 'package:crimyo/constants.dart';
import 'package:crimyo/models/department.dart';
import 'package:crimyo/screens/department_lesson_plan_list/department_lesson_plan_list.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_row.dart';

class HtmlView extends StatelessWidget {
  final String html;

  const HtmlView(this.html, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      onTapUrl: (url) async {
        if (url[0] == '/') url = baseUrl + url;
        print(url);

        // dosya
        if (url.contains('.')) {
          String extension = url.substring(url.lastIndexOf("."));
          // PDF
          if (extension == '.pdf') {
            NavigationService.push(child: DocumentScreen(url: url));
            return null;
          }
        }

        // ders programı
        RegExp regExp =
        RegExp('(\/index\.php\/tr\/.*.\/ders\-programi)\$');
        if (regExp.hasMatch(url)) {
          NavigationService.push(
            child: DepartmentLessonPlanListScreen(
              department: Department(
                name: '',
                url: url,
              ),
            ),
          );
          return null;
        }

        // tarayıcı
        if (await canLaunch(url) != null) {
          await launch(url);
          return null;
        }
      },
      customStylesBuilder: (element) {
        if (element.attributes['title'] != null)
          return {
            'color': '#000',
            'text-decoration': 'none',
          };
        return null;
      },
      customWidgetBuilder: (element) {
        // Image Row Widget
        if (element.classes.contains('sigFreeContainer')) {
          var images = element.querySelectorAll('img');
          List<String> imageUrlList =
          images.map((e) => e.attributes['src']).toList();
          return ImageRow(images: imageUrlList);
        }
        return null;
      },
      // webView: true,
    );
  }
}
