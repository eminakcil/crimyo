import 'package:flutter/material.dart';

import 'package:crimyo/components/button.dart';
import 'package:crimyo/screens/department_list/department_list.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/screens/post_list/post_list_screen.dart';
import 'package:crimyo/services/announcment_service.dart';
import 'package:crimyo/services/news_service.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          Button(
            text: "Akademik Takvim",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentScreen(
                    url:
                        "https://docs.google.com/spreadsheets/d/1xtkaCwiPCqpp3kUrzweM9bJPu2LOkJ7l4csa_lTLaE4/export?format=pdf",
                  ),
                ),
              );
            },
          ),
          VerticalDivider(),
          Button(
            text: "Yemek Listesi",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentScreen(
                    url:
                        "https://docs.google.com/spreadsheets/d/1h0bA-ByWSHOF5CGWMgsHPkSZ7WgiXMyTwrZlcu6Po0E/export?format=pdf",
                  ),
                ),
              );
            },
          ),
          VerticalDivider(),
          Button(
            text: "Haberler",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostListScreen(
                    postListFuture: NewsService().getAllNews(),
                  ),
                ),
              );
            },
          ),
          VerticalDivider(),
          Button(
            text: "Duyurular",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostListScreen(
                    postListFuture: AnnouncmentService().getAllAnnouncements(),
                  ),
                ),
              );
            },
          ),
          VerticalDivider(),
          Button(
            text: "Ders Programları",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartmentList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
