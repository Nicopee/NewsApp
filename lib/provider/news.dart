import 'dart:convert';

import 'package:FlutterNews/models/articleModel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2021-03-08&sortBy=publishedAt&apiKey=3525f8fee50d48d9b73ddb153c519bb8";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          print(jsonData);
          ArticleModel articleModel = ArticleModel(
            author: element['author'],
            title: element['title'],
            content: element['content'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
