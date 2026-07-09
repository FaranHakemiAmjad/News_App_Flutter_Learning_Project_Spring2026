import 'package:news_app/domain/models/article.dart';

import '../../../data/repository/article_repository_impl.dart';

class SavedViewModel {

  final ArticleRepositoryImpl articleRepository;

  SavedViewModel(this.articleRepository);

  List<ArticleItemModel> articles = [];

  Future<void> getSavedArticles(Function updateUi) async {
    articles = await articleRepository.getSavedArticles();
    updateUi();
  }

  Future<int> deleteArticle(String id) async {
    return await articleRepository.deleteArticle(id);
  }

}