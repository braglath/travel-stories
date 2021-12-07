import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class FullScreenStoryController extends GetxController {
  //TODO: Implement FullScreenStoryController

  final count = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    // todo check weather the user is saved this activity
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void liked(
    String likes, {
    required String authorid,
    required String authorname,
    required String likedpersonname,
    required String likedpersonid,
    required String title,
    required String category,
    required String body,
    required String date,
  }) {
    isLiked.value = !isLiked.value;
    print('is liked - $isLiked');
    if (isLiked.isTrue) {
      count.value = int.parse(likes) + 1;
      saveStory(
          authorid: authorid,
          authorname: authorname,
          likedpersonname: likedpersonname,
          likedpersonid: likedpersonid,
          title: title,
          category: category,
          body: body,
          date: date);
    } else {
      count.value = count.value - 1;
      removeStory(
          likes: likes,
          title: title,
          authorid: authorid,
          likedpersonid: likedpersonid,
          likedpersonname: likedpersonname);
    }
  }

  void saveStory({
    required String authorid,
    required String authorname,
    required String likedpersonname,
    required String likedpersonid,
    required String title,
    required String category,
    required String body,
    required String date,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/addfavstories.php';
    var uri = Uri.parse(url);
    var data = {
      "authorid": authorid,
      "authorname": authorname,
      "likedpersonname": likedpersonname,
      "likedpersonid": likedpersonid,
      "title": title,
      "category": category,
      "body": body,
      "likes": count.value.toString(),
      "date": date
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains("error")) {
      print('already liked');
      count.value = count.value - 1;
      isLiked.value = false;
      CustomSnackbar(
              title: 'Warning',
              message: 'This story is already in your favorites list')
          .showWarning();
    } else {
      if (details.toString().contains("true")) {
        print('saved to fav');
        // todo change stories table in sql
        CustomSnackbar(
                title: 'Saved',
                message:
                    'This story has been successfully saved to your favorites list')
            .showSuccess();
      } else if (details.toString().contains("false")) {
        print('check connection');
        count.value = count.value - 1;
        isLiked.value = false;
        CustomSnackbar(
                title: 'Warning', message: 'Check your internet connection')
            .showWarning();
      }
    }
  }

  void removeStory({
    required String likes,
    required String title,
    required String authorid,
    required String likedpersonid,
    required String likedpersonname,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/removefavstories.php';
    var uri = Uri.parse(url);
    var data = {
      "title": title,
      "authorid": authorid,
      "likedpersonid": likedpersonid,
      "likedpersonname": likedpersonname
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains("Story deleted successfully")) {
      // todo change stories table in sql
      print('success');
      isLiked.value = false;
      CustomSnackbar(
              title: 'Success',
              message:
                  'Successfully removed the story from your favorites list')
          .showSuccess();
    } else {
      print('error');
      CustomSnackbar(
              title: 'Warning',
              message: 'Error removing story from your favorites list')
          .showWarning();
    }
  }

// ? cheking on build part on view page
  void checkLikedStories({
    required String title,
    required String authorid,
    required String likedpersonid,
    required String likedpersonname,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/checklikedstories.php';
    var uri = Uri.parse(url);
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
