import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/Models/top_stories_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';

class TopStoriesController extends GetxController {
  static var client = http.Client();
  final count = 0.obs;
  var topStories = <TopStoriesModel>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getTopStories();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void getTopStories() async {
    isLoading.value = true;

    await APIservices.fetchTopStories().then((value) {
      if (value.isNotEmpty) {
        topStories.assignAll(value);
      }
    });
    print(topStories);

    isLoading.value = false;
  }
}
