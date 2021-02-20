import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'package:crimyo/constants.dart';
import 'package:crimyo/models/post.dart';

class ParseHelper {
  ParseHelper._privateConstructor();

  static final ParseHelper _instance = ParseHelper._privateConstructor();

  factory ParseHelper(){
    return _instance;
  }

  Dio _dio = Dio();

  List<String> getStartIndexesInDocument(Document document) {
    List<String> startIndexes = ['0'];

    var paginationElement = document.querySelector('.pagination');

    if (paginationElement != null) {
      var paginationItems = paginationElement.querySelectorAll('a');
      paginationItems.forEach((element) {
        var elementHref = element.attributes['href'];
        if (elementHref != null) {
          var uri = Uri.parse(baseUrl + elementHref);
          var parameters = uri.queryParameters;
          var startIndex = parameters['start'];
          if (startIndex != null && !startIndexes.contains(startIndex)) startIndexes.add(startIndex);
        }
      });
    }

    return startIndexes;
  }

  Future<Post> getPostDetail(Post post) async {

    final url = post.url;

    try {
      var response = await _dio.get(url);
      if (response.statusCode == 200) {
        var document = parse(response.data);

        var contentDetails = document.querySelector("#t3-content .item-page article");

        var articleTitle = contentDetails.querySelector(".article-title");
        post.title = articleTitle.text.trim();

        var articleContent = contentDetails.querySelector(".article-content");
        post.content = articleContent.text.trim();

        List<String> imageUrls = List();
        //resim tablosu
        var contentImages = contentDetails.querySelectorAll('img');

        // if (contentImages.length != 0) imageUrls = List();

        contentImages.forEach((imageElement) {
          String imageUrl;
          var imageClass = imageElement.attributes['class'];

          if (imageClass == 'sigFreeImg')
            imageUrl = imageElement.parent.attributes['href'];
          else
            imageUrl = imageElement.attributes['src'];

          if (imageUrl != null) {
            imageUrl = baseUrl + imageUrl;
            imageUrls.add(imageUrl);
          }
        });
        post.images = imageUrls;

        return post;
      } else {
        return Future.error('statusCodeError');
      }
    } catch (e) {
      return Future.error('undefinedError');
    }
  }

}