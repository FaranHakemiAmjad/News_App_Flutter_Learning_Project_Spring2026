import 'dart:convert';

class ArticleModel {
  final String? status;
  final int? totalResults;
  final List<ArticleItemModel>? results;
  final String? nextPage;

  ArticleModel({
    this.status,
    this.totalResults,
    this.results,
    this.nextPage,
  });
}

class ArticleItemModel {
  final String? articleId;
  final String? title;
  final String? link;
  final List<String>? keywords;
  final List<String>? creator;
  final String? videoUrl;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? imageUrl;
  final String? sourceId;
  final String? sourceUrl;
  final String? sourceIcon;
  final int? sourcePriority;
  final List<String>? country;
  final List<String>? category;
  final String? language;
  final String? aiTag;
  final String? sentiment;
  final String? sentimentStats;
  final String? aiRegion;
  final String? pubDateTZ;
  final String? aiOrg;
  final String? coin;
  final bool? duplicate;
  final String? aiSummary;
  final String? dataType;

  ArticleItemModel({
    this.articleId,
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.description,
    this.content,
    this.pubDate,
    this.imageUrl,
    this.sourceId,
    this.sourceUrl,
    this.sourceIcon,
    this.sourcePriority,
    this.country,
    this.category,
    this.language,
    this.aiTag,
    this.sentiment,
    this.sentimentStats,
    this.aiRegion,
    this.pubDateTZ,
    this.aiOrg,
    this.coin,
    this.duplicate,
    this.aiSummary,
    this.dataType,
  });

  Map<String, dynamic> toJsonDB() {
    return {
      'articleId': articleId,
      'title': title,
      'link': link,
      'keywords': jsonEncode(keywords),
      'creator': jsonEncode(creator),
      'videoUrl': videoUrl,
      'description': description,
      'content': content,
      'pubDate': pubDate,
      'imageUrl': imageUrl,
      'sourceId': sourceId,
      'sourceUrl': sourceUrl,
      'sourceIcon': sourceIcon,
      'sourcePriority': sourcePriority,
      'country': jsonEncode(country),
      'category': jsonEncode(category),
      'language': language,
      'aiTag': aiTag,
      'sentiment': sentiment,
      'sentimentStats': sentimentStats,
      'aiRegion': aiRegion,
      'pubDateTZ': pubDateTZ,
      'aiOrg': aiOrg,
      'coin': coin,
      'duplicate': duplicate,
      'aiSummary': aiSummary,
      'datatype': dataType,
    };
  }

  factory ArticleItemModel.fromJsonDB(Map<String, dynamic> json) {
    final duplicate;
    if(json['duplicate'] ==1) {
      duplicate = true;
    } else {
      duplicate = false;
    }
      return ArticleItemModel(
        articleId: json['articleId'],
        title: json['title'],
        link: json['link'],
        keywords: parseStringListDB(json['keywords']),
        creator: parseStringListDB(json['creator']),
        videoUrl: json['videoUrl'],
        description: json['description'],
        content: json['content'],
        pubDate: json['pubDate'],
        imageUrl: json['imageUrl'],
        sourceId: json['sourceId'],
        sourceUrl: json['sourceUrl'],
        sourceIcon: json['sourceIcon'],
        sourcePriority: json['sourcePriority'],
        country: parseStringListDB(json['country']),
        category: parseStringListDB(json['category']),
        language: json['language'],
        aiTag: json['aiTag'],
        sentiment: json['sentiment'],
        sentimentStats: json['sentimentStats'],
        aiRegion: json['aiRegion'],
        pubDateTZ: json['pubDateTZ'],
        aiOrg: json['aiOrg'],
        coin: json['coin'],
        duplicate: duplicate,
        aiSummary: json['aiSummary'],
        dataType: json['datatype'],
      );
    }
  }

  List<String> parseStringListDB(dynamic value) {
    if (value == null) {
      return [];
    }
    final result = <String>[];
    if (value is String) {
      final list = jsonDecode(value);
      for (final item in list) {
        if (item is String) {
          result.add(item.toString());
        }
      }
    }
    return result;
  }

class SentimentStatsModel {
  final int? positive;
  final int? neutral;
  final int? negative;

  SentimentStatsModel({
    this.positive,
    this.neutral,
    this.negative,
  });
}