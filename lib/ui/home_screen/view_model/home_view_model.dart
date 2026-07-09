import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/data/repository/article_repository_impl.dart';
import 'package:news_app/domain/models/article.dart';

class HomeViewModel {

  final ArticleRepositoryImpl articleRepositoryImpl;

  HomeViewModel(this.articleRepositoryImpl);

  List<ArticleItemModel> articles = [];

  bool isLoaded = false;

  Future<bool> fetchArticles(String country,Function updateUi) async {

    final connectivity = await Connectivity().checkConnectivity();

    if(isLoaded) {
      return true;
    }

    if(connectivity.contains(ConnectivityResult.none) || connectivity.contains(ConnectivityResult.wifi) ||connectivity.contains(ConnectivityResult.mobile)) {
      articles = await articleRepositoryImpl.getSavedArticles();
      isLoaded = true;
      updateUi();
      return false;
    }

    if (connectivity.contains(ConnectivityResult.vpn)) {
      switch (country) {
        case ('all') :
          articles = await articleRepositoryImpl.getArticles();
          isLoaded = true;
          updateUi();
          break;
        default:
          articles = await articleRepositoryImpl.getArticlesByCountry(country);
          isLoaded = true;
          updateUi();
      }

    }

    return true;

  }

}