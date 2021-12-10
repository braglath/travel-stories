import 'package:get/get.dart';
import 'package:travel_diaries/app/data/Models/top_stories_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';

class TopStoriesController extends GetxController {
  final count = 0.obs;
  var topStories = <TopStoriesModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTopStories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void getTopStories() async {
    isLoading.value = true;
    var topstoriesItems = await APIservices.fetchTopStories();
    if (topstoriesItems.isNotEmpty) {
      topStories.assignAll(topstoriesItems);

      isLoading.value = false;
    } else {
      isLoading.value = false;
      throw Exception();
    }
  }
}
