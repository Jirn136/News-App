import 'dart:convert';

import 'package:clean_arch_news_flutter/features/news/data/model/news_model.dart';
import 'package:http/http.dart' as http;

import '../../presentation/utils/constants.dart';

abstract class NewsDataSource {
  Future<News> getNews(String queryText);
}

class NewsDataSourceImpl implements NewsDataSource {
  @override
  Future<News> getNews(String queryText) async {
    final String url =
        "${Constants.NEWS_URL}everything?q=${queryText.isNotEmpty ? queryText : 'bitcoin'}&apiKey=${Constants.NEWS_API_KEY}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return News.fromJson(responseData);
    } else {
      print('response code failed');
      return News();
    }
  }
}
