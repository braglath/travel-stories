import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_diaries/app/data/Models/stories_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';

class SubmitStoryController extends GetxController {
  //TODO: Implement SubmitStoryController

  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;
  RxBool isLiked = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isLoading = false.obs;

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
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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
