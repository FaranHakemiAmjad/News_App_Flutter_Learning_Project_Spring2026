import 'package:news_app/data/repository/article_local_repository.dart';
import 'package:news_app/domain/models/article.dart';
import 'package:news_app/domain/models/article_dto.dart';
import 'package:news_app/domain/repository/article_repository.dart';

import 'article_remote_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {

  final ArticleRemoteRepository remoteRepository;
  final ArticleLocalRepository localRepository;

  ArticleRepositoryImpl(this.remoteRepository, this.localRepository);

  @override
  Future<List<ArticleItemModel>> getArticles() async {
    final List<ArticleItemDto> dtos = await remoteRepository.getArticlesFromApi();
    return dtos.map((dto) => dto.toModel()).toList();
  }

  @override
  Future<List<ArticleItemModel>> getArticlesByCountry(String country) async {
    final List<ArticleItemDto> dtos = await remoteRepository.getArticlesFromApiByCountry(country);
    return dtos.map((dto) => dto.toModel()).toList();
  }

  @override
  Future<bool> saveArticle(ArticleItemModel article) async {
    return await localRepository.saveArticle(article);
  }

  @override
  Future<List<ArticleItemModel>> getSavedArticles() async {
    return await localRepository.getSavedArticles();
  }

  @override
  Future<int> deleteArticle(String id) async {
    return await localRepository.deleteArticle(id);
  }

}