import 'package:news_app/domain/models/article.dart';

abstract class ArticleRepository {

  Future<List<ArticleItemModel>> getArticles();

  Future<List<ArticleItemModel>> getArticlesByCountry(String country);

  Future<bool> saveArticle(ArticleItemModel article);

  Future<List<ArticleItemModel>> getSavedArticles();

  Future<int> deleteArticle(String id);

}