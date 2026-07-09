import 'package:news_app/data/repository/article_repository_impl.dart';
import 'package:news_app/domain/models/article.dart';

class ArticleDetailViewModel {

  final ArticleRepositoryImpl articleRepository;

  ArticleDetailViewModel(this.articleRepository);

  Future<bool> saveArticle(ArticleItemModel article) async {
    return await articleRepository.saveArticle(article);
  }

}