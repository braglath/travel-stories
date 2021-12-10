// To parse this JSON data, do
//
//     final topStoriesModel = topStoriesModelFromJson(jsonString);

import 'dart:convert';

List<TopStoriesModel> topStoriesModelFromJson(String str) =>
    List<TopStoriesModel>.from(
        json.decode(str).map((x) => TopStoriesModel.fromJson(x)));

String topStoriesModelToJson(List<TopStoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopStoriesModel {
  TopStoriesModel({
    required this.id,
    required this.title,
    required this.category,
    required this.body,
    required this.likes,
    required this.personid,
    required this.personname,
    required this.personprofilepic,
    required this.dateadded,
  });

  String id;
  String title;
  String category;
  String body;
  String likes;
  String personid;
  String personname;
  String personprofilepic;
  DateTime dateadded;

  factory TopStoriesModel.fromJson(Map<String, dynamic> json) =>
      TopStoriesModel(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        body: json["body"],
        likes: json["likes"],
        personid: json["personid"],
        personname: json["personname"],
        personprofilepic: json["personprofilepic"],
        dateadded: DateTime.parse(json["dateadded"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "body": body,
        "likes": likes,
        "personid": personid,
        "personname": personname,
        "personprofilepic": personprofilepic,
        "dateadded": dateadded.toIso8601String(),
      };
}
