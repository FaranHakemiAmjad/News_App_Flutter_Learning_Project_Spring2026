import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:news_app/domain/models/article.dart';
import 'package:news_app/ui/article_detail_screen/view_model/article_detail_view_model.dart';
import 'package:news_app/ui/home_screen/widgets/image_fallback.dart';

import '../../../data/repository/article_local_repository.dart';
import '../../../data/repository/article_remote_repository.dart';
import '../../../data/repository/article_repository_impl.dart';
import '../../../data/services/api/news_api_service.dart';
import '../../../data/services/database/database_service.dart';

class ArticleDetailView extends StatefulWidget {
  ArticleDetailView({super.key, required this.article});

  final ArticleItemModel article;

  @override
  State<ArticleDetailView> createState() => _ArticleDetailViewState();
}

class _ArticleDetailViewState extends State<ArticleDetailView>
    with SingleTickerProviderStateMixin {
  late ArticleDetailViewModel _articleDetailViewModel;

  void initDependencies() {
    final newsApiService = NewsApiService();
    final databaseService = DatabaseService();
    final remoteRepository = ArticleRemoteRepository(newsApiService);
    final localRepository = ArticleLocalRepository(databaseService);
    final articleRepositoryImpl = ArticleRepositoryImpl(
      remoteRepository,
      localRepository,
    );
    _articleDetailViewModel = ArticleDetailViewModel(articleRepositoryImpl);
  }

  void saveArticle() async {
    bool isSaved = await _articleDetailViewModel.saveArticle(widget.article);
    final snackBar = SnackBar(
      content: Text(
        isSaved ? "Saved Article Successfully!" : "Failed to Save Article",
      ),
      backgroundColor: isSaved ? Colors.green.shade100 : Colors.red.shade100,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> openArticle(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  @override
  void initState() {
    super.initState();
    initDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.article.imageUrl;
    bool isImageAvailable = true;
    if (imageUrl == null || imageUrl == "") {
      isImageAvailable = false;
    }

    String dateTime = widget.article.pubDate!;
    List<String> parts = dateTime.split(" ");
    String date = parts[0];
    String time = parts[1];

    String categories = widget.article.category!.join(" | ").toUpperCase();
    String countries = widget.article.country!.join(", ").toUpperCase();
    String shortCountyList = "${widget.article.country!.first.toUpperCase()} & MORE...";

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: true,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              expandedHeight: 350.0,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                background: isImageAvailable
                    ? Hero(
                        tag: widget.article.articleId!,
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      )
                    : ImageFallback(),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Country
                  Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const Text(' '),
                      Text(
                        categories,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const Text(' '),
                      Text(
                        widget.article.country!.length > 2 ? shortCountyList
                        : countries,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18.0),
                  // Date & Time
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const Text(' '),
                      Text(
                        date,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const Text(' '),
                      Icon(
                        Icons.access_time_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const Text(' '),
                      Text(
                        time,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  const Divider(),
                  const SizedBox(height: 18.0),
                  // Title & Description
                  Text(
                    widget.article.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 18.0),
                  Text(widget.article.description ?? ""),
                  const SizedBox(height: 18.0),
                  const Divider(),
                  const SizedBox(height: 18.0),
                  // Buttons
                  Row(
                    children: [
                      TextButton(onPressed: saveArticle, child: Text("Save")),
                      TextButton(
                        onPressed: () {
                          openArticle(widget.article.link!);
                        },
                        child: Text("Open in Browser"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
