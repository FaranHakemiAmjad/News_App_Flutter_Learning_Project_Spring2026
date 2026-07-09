import 'package:news_app/data/services/database/database_service.dart';
import 'package:news_app/domain/models/article.dart';

class ArticleLocalRepository {

  final DatabaseService databaseService;

  ArticleLocalRepository(this.databaseService);

  Future<bool> saveArticle(ArticleItemModel articleItemModel) async {
    final json = articleItemModel.toJsonDB();
    return await databaseService.saveArticle(json);
  }

  Future<List<ArticleItemModel>> getSavedArticles() async {
    final List<dynamic> data = await databaseService.getSavedArticles();
    return data.map((item) => ArticleItemModel.fromJsonDB(item)).toList();
  }

  Future<int> deleteArticle(String id) async {
    return await databaseService.deleteArticle(id);
  }

}