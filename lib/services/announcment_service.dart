import 'package:dio/dio.dart';
import 'package:html/parser.dart';

import 'package:crimyo/constants.dart';
import 'package:crimyo/models/post.dart';
import 'package:crimyo/services/parse_helper.dart';

class AnnouncmentService {
  AnnouncmentService._privateConstructor();

  static final AnnouncmentService _instance = AnnouncmentService._privateConstructor();

  factory AnnouncmentService(){
    return _instance;
  }


  Dio _dio = Dio();

  var announcementsUrl = '/index.php/tr/bilgi-sistemleri/ilanlar-tr';

  Future<List<Post>> getAllAnnouncements() async {

    List<Post> announcementsList = List<Post>();

    try {
      var response = await _dio.get(baseUrl + announcementsUrl);
      if (response.statusCode == 200) {
        var document = parse(response.data);

        var startIndexes = ParseHelper().getStartIndexesInDocument(document);

        for (var index = 0; index < startIndexes.length; index++) {
          var startIndex = startIndexes[index];

          List<Post> value = await getAnnouncementsInSinglePage(startIndex: startIndex);
          value.forEach((news) {
            announcementsList.add(news);
          });
        }

        return announcementsList;
      } else {
        return Future.error('statusCodeError');
      }
    } catch (e) {
      return Future.error('undefinedError');
    }
  }

  Future<List<Post>> getAnnouncementsInSinglePage({String startIndex: '0'}) async {
    List<Post> announcementsList = List<Post>();

    var url = '$announcementsUrl?start=$startIndex';

    try {
      var response = await _dio.get(baseUrl + url);
      if (response.statusCode == 200) {
        var document = parse(response.data);

        var contentsData = document.querySelectorAll("#t3-content table tbody .list-title");
        contentsData.forEach((element) {
          var currentElement = element.querySelector("a");

          var title = currentElement.text.trim();
          var url = baseUrl + currentElement.attributes['href'];

          var currentAnnouncements = Post(title: title, url: url);

          announcementsList.add(currentAnnouncements);
        });
        return announcementsList;
      } else {
        return Future.error('statusCodeError');
      }
    } catch (e) {
      return Future.error('undefinedError');
    }
  }
}