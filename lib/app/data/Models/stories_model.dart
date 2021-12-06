// To parse this JSON data, do
//
//     final storiesModel = storiesModelFromJson(jsonString);

import 'dart:convert';

List<StoriesModel> storiesModelFromJson(String str) => List<StoriesModel>.from(
    json.decode(str).map((x) => StoriesModel.fromJson(x)));

String storiesModelToJson(List<StoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoriesModel {
  StoriesModel({
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

  factory StoriesModel.fromJson(Map<String, dynamic> json) => StoriesModel(
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
        "dateadded":
            "${dateadded.year.toString().padLeft(4, '0')}-${dateadded.month.toString().padLeft(2, '0')}-${dateadded.day.toString().padLeft(2, '0')}",
      };
}
