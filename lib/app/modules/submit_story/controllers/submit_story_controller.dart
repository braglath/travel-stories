import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Models/stories_model.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class SubmitStoryController extends GetxController {
  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;
  RxBool isLiked = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isLoading = false.obs;
  final scrollController = ScrollController().obs;
  var shouldAutoscroll = false.obs;
  DateTime timeBackButtonPressed = DateTime.now();

  List<String> travelmodes =
      ['All', 'Cycle', 'Bike', 'Car', 'Bus', 'Train', 'Flight'].obs;
  List<IconData> travelIcons = [
    Icons.flutter_dash,
    Icons.directions_bike_sharp,
    Icons.motorcycle_rounded,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.train,
    Icons.flight_takeoff,
  ].obs;

  List<StoriesModel> story = <StoriesModel>[].obs;

  @override
  void onInit() {
    fetchStories(travelmodes[defaultChoiceIndex.value]);
    scrollController.value.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.value.removeListener(_scrollListener);
  }

  Future<bool> pressBackAgainToExit() async {
    final difference = DateTime.now().difference(timeBackButtonPressed);
    final isExitWarning = difference >= Duration(seconds: 2);
    timeBackButtonPressed = DateTime.now();
    if (isExitWarning) {
      CustomSnackbar(
              title: 'Exiting the app',
              message: 'Press back button again to exit the app')
          .showWarning();
      return false;
    } else {
      Get.closeCurrentSnackbar();
      return true;
    }
  }

  void scrollToTop() {
    final double start = 0;
    scrollController.value.animateTo(start,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void _scrollListener() {
    if (scrollController.value.hasClients &&
        scrollController.value.position.pixels >= 150) {
      shouldAutoscroll.value = true;
    } else {
      shouldAutoscroll.value = false;
    }
  }

  void fetchStories(String category) async {
    isLoading.value = true;
    print('i am here');
    var stories = await refreshStories(category);

    if (stories.isNotEmpty) {
      story.add(stories[0]);
      print('fetch stories length - ${stories.length}');
      isLoading.value = false;
      isEmpty.value = false;
    } else {
      isEmpty.value = true;
      isLoading.value = false;
    }
  }

  Future<List<StoriesModel>> refreshStories(String category) async {
    print(category);
    var url = 'http://ubermensch.studio/travel_stories/getstories.php';
    var data = {
      "category": category,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonString = res.body;
      print(jsonString);
      final totalmodel = storiesModelFromJson(jsonString);
      story.assignAll(totalmodel);
      List jsonResponse = json.decode(res.body);
      return jsonResponse.map((e) => StoriesModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
