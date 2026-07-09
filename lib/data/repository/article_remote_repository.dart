import 'dart:convert';

import '../../domain/models/article_dto.dart';
import '../../utils/variables.dart';
import '../services/api/news_api_service.dart';

class ArticleRemoteRepository {

  final NewsApiService newsApiService;

  ArticleRemoteRepository(this.newsApiService);

  Future<List<ArticleItemDto>> getArticlesFromApi() async {
    try {
      final response = await newsApiService.fetchArticles();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> articlesJson = data['results'];

        return articlesJson.map((json) => ArticleItemDto.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load articles");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<ArticleItemDto>> getArticlesFromApiByCountry(String country) async {
    try {
      final String url = urlGenerator(country);
      final response = await newsApiService.fetchArticlesByCountry(country, url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> articlesJson = data['results'];

        return articlesJson.map((json) => ArticleItemDto.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load articles");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

}