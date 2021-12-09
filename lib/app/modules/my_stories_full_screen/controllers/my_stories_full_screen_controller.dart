import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyStoriesFullScreenController extends GetxController {
  
  final count = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
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
