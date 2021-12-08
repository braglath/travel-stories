import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Models/fav_stories_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class FaveStoriesController extends GetxController {
  //TODO: Implement FaveStoriesController

  final count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLiked = false.obs;
  List<FavStoriesModel> story = <FavStoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavStories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void fetchFavStories() async {
    isLoading.value = true;

    var stories = await APIservices.fetchFavStories();

    if (stories.isNotEmpty) {
      story.addAll(stories);
      isLoading.value = false;
    } else {
      print('Nothing to show');
      isLoading.value = false;
    }
  }

  Future<List<FavStoriesModel>> refreshFavStories() async {
    var stories = await APIservices.fetchFavStories();
    if (stories.isNotEmpty) {
      story.addAll(stories);
      isLoading.value = false;
      return story;
    } else {
      print('Nothing to show');
      isLoading.value = false;
      return story;
    }
  }

  void liked(
    String likes, {
    required String authorid,
    required String authorname,
    required String authorprofilepic,
    required String likedpersonname,
    required String likedpersonid,
    required String title,
    required String category,
    required String body,
    required String date,
    required FavStoriesModel storiesIndex,
  }) {
    count.value = count.value - 1;
    removeStory(
        likes: likes,
        title: title,
        authorid: authorid,
        likedpersonid: likedpersonid,
        likedpersonname: likedpersonname,
        authorName: authorname,
        storiesIndex: storiesIndex);
  }

  void removeStory({
    required String likes,
    required String title,
    required String authorid,
    required String likedpersonid,
    required String likedpersonname,
    required String authorName,
    required FavStoriesModel storiesIndex,
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
      Get.back();
      updateStoriesAfterLikes(
          authorID: authorid,
          authorName: authorName,
          title: title,
          likes: count.value.toString(),
          storiesIndex: storiesIndex);
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

  // ? updating stories after likes or dislikes
  void updateStoriesAfterLikes({
    required String authorID,
    required String authorName,
    required String title,
    required String likes,
    required FavStoriesModel storiesIndex,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/updatestorieslikes.php';
    var data = {
      "likes": likes,
      "personid": authorID,
      "personname": authorName,
      "title": title
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));

    if (res.statusCode == 200) {
      print('stories updated');
      story.remove(storiesIndex);
    } else {
      print('error updating stories');
    }
  }
}
