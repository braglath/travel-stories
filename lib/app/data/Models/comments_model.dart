import 'dart:convert';

// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

List<CommentsModel> commentsModelFromJson(String str) =>
    List<CommentsModel>.from(
        json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModel {
  CommentsModel({
    required this.id,
    required this.commenterid,
    required this.commentername,
    required this.commenterprofilepic,
    required this.comment,
    required this.storyid,
    required this.storytitle,
    required this.isliked,
    required this.datecommented,
  });

  String id;
  String commenterid;
  String commentername;
  String commenterprofilepic;
  String comment;
  String storyid;
  String storytitle;
  String isliked;
  DateTime datecommented;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json['id'],
        commenterid: json['commenterid'],
        commentername: json['commentername'],
        commenterprofilepic: json['commenterprofilepic'],
        comment: json['comment'],
        storyid: json['storyid'],
        storytitle: json['storytitle'],
        isliked: json['isliked'],
        datecommented: DateTime.parse(json['datecommented']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'commenterid': commenterid,
        'commentername': commentername,
        'commenterprofilepic': commenterprofilepic,
        'comment': comment,
        'storyid': storyid,
        'storytitle': storytitle,
        'isliked': isliked,
        'datecommented': datecommented.toIso8601String(),
      };
}
