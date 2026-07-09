import 'package:flutter/material.dart';
import 'package:news_app/ui/saved_screen/view_model/saved_view_model.dart';

import '../../../data/repository/article_local_repository.dart';
import '../../../data/repository/article_remote_repository.dart';
import '../../../data/repository/article_repository_impl.dart';
import '../../../data/services/api/news_api_service.dart';
import '../../../data/services/database/database_service.dart';
import '../../home_screen/widgets/article_card.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  late SavedViewModel _savedViewModel;

  void initDependencies() {
    final newsApiService = NewsApiService();
    final databaseService = DatabaseService();
    final remoteRepository = ArticleRemoteRepository(newsApiService);
    final localRepository = ArticleLocalRepository(databaseService);
    final articleRepositoryImpl = ArticleRepositoryImpl(
      remoteRepository,
      localRepository,
    );
    _savedViewModel = SavedViewModel(articleRepositoryImpl);
  }

  void deleteArticle(String id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 100,
          child: Column(
            children: [
              SizedBox(height: 18.0,),
              const Text("Are you sure you want to remove this article?"),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      int result = await _savedViewModel.deleteArticle(id);
                      await _savedViewModel.getSavedArticles(() {
                        setState(() {});
                      });
                      Navigator.of(context).pop();

                      // Snack Bar

                      final snackBar = SnackBar(
                        content: Text(
                          result == 1
                              ? "Deleted Article Successfully!"
                              : "Failed to Delete Article",
                        ),
                        backgroundColor: result == 1
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      _savedViewModel.getSavedArticles(() {
                        setState(() {});
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initDependencies();
    _savedViewModel.getSavedArticles(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Articles")),
      body: _savedViewModel.articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _savedViewModel.articles.length,
              itemBuilder: (context, index) {
                final article = _savedViewModel.articles[index];

                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: ValueKey(_savedViewModel.articles[index]),
                  background: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Theme.of(context).colorScheme.error, Colors.white], begin: AlignmentGeometry.centerRight, end: AlignmentGeometry.centerLeft),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete_forever_outlined),
                      ],
                    )
                  ),
                  onDismissed: (direction) {
                    deleteArticle(article.articleId!);
                  },
                  child: ArticleCard(article: article),
                );
              },
            ),
    );
  }
}
