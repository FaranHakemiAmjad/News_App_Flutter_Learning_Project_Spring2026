import 'package:http/http.dart' as http;
import 'package:news_app/utils/variables.dart';

class NewsApiService {

  Future<http.Response> fetchArticles() async {
    return await http.get(Uri.parse(apiUrl));
  }

  Future<http.Response> fetchArticlesByCountry(String country, String url) async {
    return await http.get(Uri.parse(url));
  }

}