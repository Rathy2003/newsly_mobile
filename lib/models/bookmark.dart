import 'package:newsly/models/news.dart';

class Bookmark{
  int? id;
  News? news;
  Bookmark({this.id, this.news});

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json["id"],
      news: News.fromJson(json["news"])
    );
  }
}