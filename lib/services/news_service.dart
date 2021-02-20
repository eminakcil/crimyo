import 'package:dio/dio.dart';
import 'package:html/parser.dart';

import 'package:crimyo/constants.dart';
import 'package:crimyo/models/post.dart';
import 'package:crimyo/services/parse_helper.dart';

class NewsService {

  NewsService._privateConstructor();

  static final NewsService _instance = NewsService._privateConstructor();

  factory NewsService(){
    return _instance;
  }


  Dio _dio = Dio();

  var newsUrl = '/index.php/tr/bilgi-sistemleri/haberler-tr';

  Future<List<Post>> getAllNews() async {

    List<Post> newsList = List<Post>();

    try {
      var response = await _dio.get(baseUrl + newsUrl);
      if (response.statusCode == 200) {
        var document = parse(response.data);

        var startIndexes = ParseHelper().getStartIndexesInDocument(document);

        for (var index = 0; index < startIndexes.length; index++) {
          var startIndex = startIndexes[index];

          List<Post> value = await getNewsInSinglePage(startIndex: startIndex);
          value.forEach((news) {
            newsList.add(news);
          });
        }

        return newsList;
      } else {
        return Future.error('statusCodeError');
      }
    } catch (e) {
      return Future.error('undefinedError');
    }
  }

  Future<List<Post>> getNewsInSinglePage({String startIndex: '0'}) async {
    List<Post> newsList = List<Post>();

    var url = '$newsUrl?start=$startIndex';

    try {
      var response = await _dio.get(baseUrl + url);
      if (response.statusCode == 200) {
        var document = parse(response.data);

        var contentsData = document.querySelectorAll("#t3-content table tbody .list-title");
        contentsData.forEach((element) {
          var currentElement = element.querySelector("a");

          var title = currentElement.text.trim();
          var url = baseUrl + currentElement.attributes['href'];

          var currentNews = Post(title: title, url: url);

          newsList.add(currentNews);
        });
        return newsList;
      } else {
        return Future.error('statusCodeError');
      }
    } catch (e) {
      return Future.error('undefinedError');
    }
  }

}