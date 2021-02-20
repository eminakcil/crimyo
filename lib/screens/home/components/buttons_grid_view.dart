import 'package:flutter/material.dart';

import 'package:crimyo/components/centered_grid_view.dart';
import 'package:crimyo/screens/department_list/department_list.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/screens/post_list/post_list_screen.dart';
import 'package:crimyo/services/announcment_service.dart';
import 'package:crimyo/services/news_service.dart';

import 'menu_button.dart';

class ButtonsGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _buttons = [
      Center(
        child: MenuButton(
          text: "Haberler",
          iconColor: Colors.black,
          color: Color(0xFFC4C4C4),
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
      ),
      Center(
        child: MenuButton(
          text: "Duyurular",
          iconColor: Colors.black,
          color: Color(0xFFC4C4C4),
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
      ),
      Center(
        child: MenuButton(
          text: "Ders Programları",
          iconColor: Colors.black,
          color: Color(0xFFC4C4C4),
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepartmentList(),
              ),
            );
          },
        ),
      ),
    ];

    var fastButtons = [
      {
        "content": "document",
        "text": "Akademik Takvim",
        "url":
            "https://docs.google.com/spreadsheets/d/1xtkaCwiPCqpp3kUrzweM9bJPu2LOkJ7l4csa_lTLaE4/export?format=pdf",
      },
      {
        "content": "document",
        "text": "Yemek Listesi",
        "url":
            "https://docs.google.com/spreadsheets/d/1h0bA-ByWSHOF5CGWMgsHPkSZ7WgiXMyTwrZlcu6Po0E/export?format=pdf",
      },
    ];

    var _children = _buttons;

    fastButtons.forEach((element) {
      if (element["content"] == "document") {
        _children.add(Center(
          child: MenuButton(
            text: element["text"],
            iconColor: Colors.black,
            color: Color(0xFFC4C4C4),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentScreen(
                    url: element["url"],
                  ),
                ),
              );
            },
          ),
        ));
      }
    });

    return CenteredGridView(
      crossAxisCount: 3,
      children: _children,
    );
  }
}
