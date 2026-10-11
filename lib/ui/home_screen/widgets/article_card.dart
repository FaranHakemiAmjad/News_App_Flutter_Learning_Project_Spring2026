import 'package:flutter/material.dart';
import 'package:news_app/domain/models/article.dart';
import 'package:news_app/ui/article_detail_screen/view/article_detail_view.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});

  final ArticleItemModel article;

  @override
  Widget build(BuildContext context) {

    final imageUrl = article.imageUrl;
    bool isImageAvailable = true;
    if(imageUrl == null || imageUrl == "") {
      isImageAvailable = false;
    }

    String dateTime = article.pubDate!;
    List<String> parts = dateTime.split(" ");
    String date = parts[0];
    String time = parts[1];

    return Padding(
      padding: EdgeInsetsGeometry.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailView(article: article),
            ),
          );
        },
        splashColor: Colors.white,
        focusColor: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        child: SafeArea(
          child: Container(
            // height: 310,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: BoxBorder.all(color: Colors.black54, width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Title Text
                  Text(article.title!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      overflow: TextOverflow.fade
                    )
                  ),
                SizedBox(height: 18.0,),
                //   Image
                  SizedBox(
                    child: isImageAvailable ? ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20.0),
                      child: Hero(
                        tag: article.articleId!,
                        child: Image.network(
                          imageUrl!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ) : Container(child: Icon(Icons.broken_image_outlined), height: 200.0,)
                  ),
                SizedBox(height: 18.0,),
                //   Category, Pub Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
          
                      // Category
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(article.category!.first.toUpperCase(), style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary
                          )),
                          article.category!.length > 1 ?
                          Row(
                            children: [
                              Text(" | "),
                              Text(article.category![1].toUpperCase(), style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.secondary
                              )),
                            ],
                          ) : Text('')
                        ],
                      ),
                    //   Pub Date
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, color: Theme.of(context).colorScheme.secondary, size: 15.0,),
                          Text(date, style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Theme.of(context).colorScheme.secondary
                          )),
                          // Icon(Icons.access_time_outlined,  color: Theme.of(context).colorScheme.secondary, size: 15.0,),
                          // Text(time, style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          //     color: Theme.of(context).colorScheme.secondary
                          // )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
