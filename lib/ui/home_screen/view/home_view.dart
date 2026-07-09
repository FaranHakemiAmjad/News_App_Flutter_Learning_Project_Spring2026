import 'package:flutter/material.dart';
import 'package:news_app/data/repository/article_local_repository.dart';
import 'package:news_app/data/repository/article_remote_repository.dart';
import 'package:news_app/data/repository/article_repository_impl.dart';
import 'package:news_app/data/services/api/news_api_service.dart';
import 'package:news_app/data/services/database/database_service.dart';
import 'package:news_app/ui/home_screen/view_model/home_view_model.dart';

import '../widgets/article_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedCountry = "all";
  late HomeViewModel _homeViewModel;
  late bool _isOnline;

  void initDependencies() {
    final newsApiService = NewsApiService();
    final databaseService = DatabaseService();
    final remoteRepository = ArticleRemoteRepository(newsApiService);
    final localRepository = ArticleLocalRepository(databaseService);
    final articleRepositoryImpl = ArticleRepositoryImpl(
      remoteRepository,
      localRepository,
    );
    _homeViewModel = HomeViewModel(articleRepositoryImpl);
  }

  refreshPage(String country) async {
    _homeViewModel.isLoaded = false;
    _homeViewModel.articles.clear();
    _isOnline = await _homeViewModel.fetchArticles(country, () {
      setState(() {});
    });

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.wifi_off_outlined, color: Colors.white),
          Text(" No Internet Connection"),
        ],
      ),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );

    !_isOnline ? ScaffoldMessenger.of(context).showSnackBar(snackBar) : () {};
  }

  @override
  void initState() {
    super.initState();
    initDependencies();
    _homeViewModel.fetchArticles(_selectedCountry, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News App")),
      body: RefreshIndicator(
        onRefresh: () async {
          refreshPage(_selectedCountry);
        },
        child: Column(
          children: [
            SizedBox(height: 18.0),
            // Filters
            SegmentedButton(
              segments: const [
                ButtonSegment(value: 'all', label: Text("All")),
                ButtonSegment(value: 'usa', label: Text("USA")),
                ButtonSegment(value: 'china', label: Text("China")),
                ButtonSegment(value: 'iran', label: Text("Iran")),
                ButtonSegment(value: 'russia', label: Text("Russia")),
              ],
              selected: {'$_selectedCountry'},
              showSelectedIcon: false,
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedCountry = newSelection.first;
                  refreshPage(_selectedCountry);
                });
              },
            ),
            SizedBox(height: 18.0),
            // Articles List
            Expanded(
              child: Container(
                child: _homeViewModel.articles.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _homeViewModel.articles.length,
                        itemBuilder: (context, index) {
                          final article = _homeViewModel.articles[index];

                          return ArticleCard(article: article);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
