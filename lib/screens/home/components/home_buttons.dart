import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:crimyo/components/centered_grid_view.dart';
import 'package:crimyo/screens/department_list/department_list.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/screens/post_list/post_list_screen.dart';
import 'package:crimyo/services/announcment_service.dart';
import 'package:crimyo/services/news_service.dart';
import 'package:crimyo/services/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu_button.dart';

class HomeButtons extends StatefulWidget {
  @override
  _HomeButtonsState createState() => _HomeButtonsState();
}

class _HomeButtonsState extends State<HomeButtons> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var fastButtons = [];

  @override
  void initState() {
    firestore
        .collection("fastButtons")
        .orderBy("index", descending: true)
        .get()
        .then((value) {
      var _list = [];
      value.docs.forEach((element) {
        var data = element.data();

        if (data["active"]) {
          switch (data["view"]) {
            case "document":
              _list.add(Center(
                child: MenuButton(
                  text: data["title"],
                  imageUrl: data["image"],
                  color: Color(0xFFC4C4C4),
                  press: () {
                    NavigationService.push(
                      child: DocumentScreen(
                        url: data["url"],
                        title: data["title"],
                      ),
                    );
                  },
                ),
              ));
              break;
            case "link":
              _list.add(Center(
                child: MenuButton(
                  text: data["title"],
                  imageUrl: data["image"],
                  press: () async {
                    var url = data["target"];
                    if (await canLaunch(url) != null) {
                      await launch(url);
                    }
                  },
                ),
              ));
              break;
            default:
          }
        }
      });

      setState(() {
        fastButtons = _list;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _buttons = [
      Center(
        child: MenuButton(
          text: "Haberler",
          imageProvider: AssetImage("assets/images/news_icon.png"),
          color: Color(0xFFC4C4C4),
          press: () {
            NavigationService.push(
              child: PostListScreen(
                postListFuture: NewsService().getAllNews(),
                title: "Haberler",
              ),
            );
          },
        ),
      ),
      Center(
        child: MenuButton(
          text: "Duyurular",
          imageProvider: AssetImage("assets/images/announcments_icon.png"),
          color: Color(0xFFC4C4C4),
          press: () {
            NavigationService.push(
              child: PostListScreen(
                postListFuture: AnnouncmentService().getAllAnnouncements(),
                title: "Duyurular",
              ),
            );
          },
        ),
      ),
      Center(
        child: MenuButton(
          text: "Ders Programları",
          imageProvider: AssetImage("assets/images/lesson_plan_icon.png"),
          color: Color(0xFFC4C4C4),
          press: () {
            NavigationService.push(
              child: DepartmentList(),
            );
          },
        ),
      ),
    ];

    var _children = <Widget>[..._buttons, ...fastButtons];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CenteredGridView(
          crossAxisCount: 3,
          children: _children,
        ),
      ],
    );
  }
}
