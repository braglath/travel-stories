import 'dart:convert';

// To parse this JSON data, do
//
//     final favStoriesModel = favStoriesModelFromJson(jsonString);

List<FavStoriesModel> favStoriesModelFromJson(String str) =>
    List<FavStoriesModel>.from(
        json.decode(str).map((x) => FavStoriesModel.fromJson(x)));

String favStoriesModelToJson(List<FavStoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavStoriesModel {
  FavStoriesModel({
    required this.id,
    required this.authorid,
    required this.authorname,
    required this.authorprofilepic,
    required this.likedpersonname,
    required this.likedpersonid,
    required this.title,
    required this.category,
    required this.body,
    required this.likes,
    required this.date,
  });

  String id;
  String authorid;
  String authorname;
  String authorprofilepic;
  String likedpersonname;
  String likedpersonid;
  String title;
  String category;
  String body;
  String likes;
  String date;

  factory FavStoriesModel.fromJson(Map<String, dynamic> json) =>
      FavStoriesModel(
        id: json['id'],
        authorid: json['authorid'],
        authorname: json['authorname'],
        authorprofilepic: json['authorprofilepic'],
        likedpersonname: json['likedpersonname'],
        likedpersonid: json['likedpersonid'],
        title: json['title'],
        category: json['category'],
        body: json['body'],
        likes: json['likes'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'authorid': authorid,
        'authorname': authorname,
        'authorprofilepic': authorprofilepic,
        'likedpersonname': likedpersonname,
        'likedpersonid': likedpersonid,
        'title': title,
        'category': category,
        'body': body,
        'likes': likes,
        'date': date,
      };
}
