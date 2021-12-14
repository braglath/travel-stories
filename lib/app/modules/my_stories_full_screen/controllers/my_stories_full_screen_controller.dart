import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/Models/comments_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class MyStoriesFullScreenController extends GetxController {
  final count = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isLoading = false.obs;
  final height = 0.obs;
  RxBool isLarge = false.obs;
  RxString comment = ''.obs;
  RxString storyID = ''.obs;
  RxString storyTitle = ''.obs;
  var comments = <CommentsModel>[].obs;
  GlobalKey<FormState> commentkey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getComments();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void animateContainer() {
    if (isLarge.value == false) {
      height.value = 125;
      isLarge.value = true;
    } else {
      height.value = 0;
      isLarge.value = false;
    }
  }

  String? validateComment(String value) {
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  void commentValidator() {
    final isValid = commentkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      commentkey.currentState?.save();
      postComments();
    }
  }

  void postComments() async {
    var url = 'http://ubermensch.studio/travel_stories/postcomments.php';
    var data = {
      "commenterid": UserDetails().readUserIDfromBox(),
      "commentername": UserDetails().readUserNamefromBox(),
      "commenterprofilepic": UserDetails().readUserProfilePicfromBox(),
      "comment": comment.toString(),
      "storyid": storyID.toString(),
      "storytitle": storyTitle.toString(),
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains("already commented")) {
      print('already commented');
      CustomSnackbar(
              title: 'Warning',
              message: 'You have alrady commented for this story')
          .showWarning();
    } else {
      if (details.toString().contains("true")) {
        print('comment posted');
        getComments();
        // await APIservices.getComments(
        //         storyid: storyID.toString(), storytitle: storyTitle.toString())
        //     .then((value) => comments.assignAll(value));
        print('storyid - $storyID \n storytitle - $storyTitle');
        // todo change stories table in sql
        CustomSnackbar(
                title: 'Posted',
                message: 'Your comment has been successfully posted')
            .showSuccess();
      } else if (details.toString().contains("false")) {
        print('check connection');
        CustomSnackbar(
                title: 'Warning', message: 'Check your internet connection')
            .showWarning();
      }
    }
  }

  void getComments() async {
    await APIservices.myFavComments(storytitle: storyTitle.toString())
        .then((value) => comments.assignAll(value));
  }

  // ? cheking on build part on view page
  void checkLikedStories({
    required String title,
    required String authorid,
    required String likedpersonid,
    required String likedpersonname,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/checklikedstories.php';
    var data = {
      "title": title,
      "authorid": authorid,
      "likedpersonid": likedpersonid,
      "likedpersonname": likedpersonname
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains("true")) {
      print('already liked');
      isLiked.value = true;
    } else {
      print('not liked before');
      isLiked.value = false;
    }
  }
}
