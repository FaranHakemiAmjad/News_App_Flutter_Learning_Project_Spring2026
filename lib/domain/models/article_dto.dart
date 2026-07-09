import 'dart:convert';

import 'article.dart';

class ArticleDto extends ArticleModel {
  ArticleDto({super.status, super.totalResults, super.results, super.nextPage});

  factory ArticleDto.fromJson(Map<String, dynamic> json) {
    return ArticleDto(
      status: json['status']?.toString(),
      totalResults: json['totalResults'],
      nextPage: json['nextPage'],
      results: (json['results'] as List?)
          ?.map((e) => ArticleItemDto.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'nextPage': nextPage,
      'results': results?.map((e) => (e as ArticleItemDto).toJson()).toList(),
    };
  }
}

class ArticleItemDto extends ArticleItemModel {
  ArticleItemDto({
    super.articleId,
    super.title,
    super.link,
    super.keywords,
    super.creator,
    super.videoUrl,
    super.description,
    super.content,
    super.pubDate,
    super.imageUrl,
    super.sourceId,
    super.sourceUrl,
    super.sourceIcon,
    super.sourcePriority,
    super.country,
    super.category,
    super.language,
    super.aiTag,
    super.sentiment,
    super.sentimentStats,
    super.aiRegion,
    super.pubDateTZ,
    super.aiOrg,
    super.coin,
    super.duplicate,
    super.aiSummary,
    super.dataType,
  });

  factory ArticleItemDto.fromJson(Map<String, dynamic> json) {
    return ArticleItemDto(
      articleId: json['article_id'],
      title: json['title'],
      link: json['link'],
      keywords: parseStringList(json['keywords']),
      creator: parseStringList(json['creator']),
      videoUrl: json['video_url'],
      description: json['description'],
      content: json['content'],
      pubDate: json['pubDate'],
      imageUrl: json['image_url'],
      sourceId: json['source_id'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      sourcePriority: json['source_priority'],
      country: parseStringList(json['country']),
      category: parseStringList(json['category']),
      language: json['language'],
      aiTag: json['ai_tag'],
      sentiment: json['sentiment'],
      sentimentStats: json['sentiment_stats'],
      aiRegion: json['ai_region'],
      pubDateTZ: json['pubDateTZ'],
      aiOrg: json['ai_org'],
      coin: json['coin'],
      duplicate: json['duplicate'],
      aiSummary: json['ai_summary'],
      dataType: json['datatype'],
    );
  }

  factory ArticleItemDto.fromJsonDB(Map<String, dynamic> json) {
    return ArticleItemDto(
      articleId: json['article_id'],
      title: json['title'],
      link: json['link'],
      keywords: parseStringListDB(json['keywords']),
      creator: parseStringListDB(json['creator']),
      videoUrl: json['video_url'],
      description: json['description'],
      content: json['content'],
      pubDate: json['pubDate'],
      imageUrl: json['image_url'],
      sourceId: json['source_id'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      sourcePriority: json['source_priority'],
      country: parseStringListDB(json['country']),
      category: parseStringListDB(json['category']),
      language: json['language'],
      aiTag: json['ai_tag'],
      sentiment: json['sentiment'],
      sentimentStats: json['sentiment_stats'],
      aiRegion: json['ai_region'],
      pubDateTZ: json['pubDateTZ'],
      aiOrg: json['ai_org'],
      coin: json['coin'],
      duplicate: json['duplicate'],
      aiSummary: json['ai_summary'],
      dataType: json['datatype'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'link': link,
      'keywords': keywords,
      'creator': creator,
      'video_url': videoUrl,
      'description': description,
      'content': content,
      'pubDate': pubDate,
      'image_url': imageUrl,
      'source_id': sourceId,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'source_priority': sourcePriority,
      'country': country,
      'category': category,
      'language': language,
      'ai_tag': aiTag,
      'sentiment': sentiment,
      'sentiment_stats': (sentimentStats as SentimentStatsDto?)?.toJson(),
      'ai_region': aiRegion,
      'pubDateTZ': pubDateTZ,
      'ai_org': aiOrg,
      'coin': coin,
      'duplicate': duplicate,
      'ai_summary': aiSummary,
      'datatype': dataType,
    };
  }

  Map<String, dynamic> toJsonDB() {
    return {
      'article_id': articleId,
      'title': title,
      'link': link,
      'keywords': jsonEncode(keywords),
      'creator': jsonEncode(creator),
      'video_url': videoUrl,
      'description': description,
      'content': content,
      'pubDate': pubDate,
      'image_url': imageUrl,
      'source_id': sourceId,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'source_priority': sourcePriority,
      'country': jsonEncode(country),
      'category': jsonEncode(category),
      'language': language,
      'ai_tag': aiTag,
      'sentiment': sentiment,
      'sentiment_stats': sentimentStats,
      'ai_region': aiRegion,
      'pubDateTZ': pubDateTZ,
      'ai_org': aiOrg,
      'coin': coin,
      'duplicate': duplicate,
      'ai_summary': aiSummary,
      'datatype': dataType,
    };
  }

  ArticleItemModel toModel() {
    return ArticleItemModel(
      articleId: articleId,
      title: title,
      link: link,
      keywords: keywords,
      creator: creator,
      videoUrl: videoUrl,
      description: description,
      content: content,
      pubDate: pubDate,
      imageUrl: imageUrl,
      sourceId: sourceId,
      sourceUrl: sourceUrl,
      sourceIcon: sourceIcon,
      sourcePriority: sourcePriority,
      country: country,
      category: category,
      language: language,
      aiTag: aiTag,
      sentiment: sentiment,
      sentimentStats: sentimentStats,
      aiRegion: aiRegion,
      pubDateTZ: pubDateTZ,
      aiOrg: aiOrg,
      coin: coin,
      duplicate: duplicate,
      aiSummary: aiSummary,
      dataType: dataType,
    );
  }

  static List<String> parseStringList(dynamic value) {
    if (value == null) {
      return [];
    }
    final result = <String>[];
    if (value is String) {
      result.add(value.toString());
    } else {
      for (final item in value) {
        if (item is String) {
          result.add(item.toString());
        } else {
          result.addAll(item.values.map((e) => e.toString()));
        }
      }
    }
    return result;
  }

  static List<String> parseStringListDB(dynamic value) {
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
}

class SentimentStatsDto extends SentimentStatsModel {
  SentimentStatsDto({super.positive, super.neutral, super.negative});

  factory SentimentStatsDto.fromJson(Map<String, dynamic> json) {
    return SentimentStatsDto(
      positive: json['positive'],
      neutral: json['neutral'],
      negative: json['negative'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'positive': positive, 'neutral': neutral, 'negative': negative};
  }
}
