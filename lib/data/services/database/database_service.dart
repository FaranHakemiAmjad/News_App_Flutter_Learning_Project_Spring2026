import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final _databaseName = 'news_app.db';
  static final _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE articles (
            articleId TEXT PRIMARY KEY,
            title TEXT,
            link TEXT,
            keywords TEXT,
            creator TEXT,
            videoUrl TEXT,
            description TEXT,
            content TEXT,
            pubDate TEXT,
            imageUrl TEXT,
            sourceId TEXT,
            sourceUrl TEXT,
            sourceIcon TEXT,
            sourcePriority INTEGER,
            country TEXT,
            category TEXT,
            language TEXT,
            aiTag TEXT,
            sentiment TEXT,
            sentimentStats TEXT,
            aiRegion TEXT,
            pubDateTZ TEXT,
            aiOrg TEXT,
            coin TEXT,
            duplicate INTEGER,
            aiSummary TEXT,
            dataType TEXT)'''
        );
      },
    );
  }

  Future<bool> saveArticle(Map<String, Object?> articleJson) async {
    final db = await database;
    try {
      db.insert(
          'articles',
          articleJson,
          conflictAlgorithm: ConflictAlgorithm.replace
      );
      return true;

    } catch (error) {
      return false;
    }
  }

  Future<List<Map<String,Object?>>> getSavedArticles() async {
    final db = await database;
    return await db.query('articles');
  }
  
  Future<int> deleteArticle(String id) async {
    final db = await database;
    return await db.delete('articles', where: 'articleId = ?', whereArgs: [id]);
  }

}
