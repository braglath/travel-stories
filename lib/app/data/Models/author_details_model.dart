import 'dart:convert';

// To parse this JSON data, do
//
//     final authorDetailsModel = authorDetailsModelFromJson(jsonString);

List<AuthorDetailsModel> authorDetailsModelFromJson(String str) =>
    List<AuthorDetailsModel>.from(
        json.decode(str).map((x) => AuthorDetailsModel.fromJson(x)));

String authorDetailsModelToJson(List<AuthorDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorDetailsModel {
  AuthorDetailsModel({
    required this.id,
    required this.name,
    required this.phoneoremail,
    required this.password,
    required this.fav,
    required this.caption,
    required this.profilepicture,
    required this.datecreated,
  });

  String id;
  String name;
  String phoneoremail;
  String password;
  String fav;
  String caption;
  String profilepicture;
  DateTime datecreated;

  factory AuthorDetailsModel.fromJson(Map<String, dynamic> json) =>
      AuthorDetailsModel(
        id: json["id"],
        name: json["name"],
        phoneoremail: json["phoneoremail"],
        password: json["password"],
        fav: json["fav"],
        caption: json["caption"],
        profilepicture: json["profilepicture"],
        datecreated: DateTime.parse(json["datecreated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneoremail": phoneoremail,
        "password": password,
        "fav": fav,
        "caption": caption,
        "profilepicture": profilepicture,
        "datecreated": datecreated.toIso8601String(),
      };
}
