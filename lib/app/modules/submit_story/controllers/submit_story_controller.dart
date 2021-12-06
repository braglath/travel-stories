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

  final count = 0.obs;
  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;

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

  final List<StoriesModel> story = <StoriesModel>[].obs;
  get taskList => this.story;

  bool isSelectedLabel() => isSelected.value = true;

  @override
  void onInit() {
    fetchStories();
    super.onInit();
  }

  @override
  void onReady() {
    fetchStories();

    super.onReady();
  }

  @override
  void onClose() {
    fetchStories();
  }

  void increment() => count.value++;

  void fetchStories() async {
    print('i am here');
    var stories = await APIservices.getStories();
    if (stories.isNotEmpty) {
      story.assignAll(stories);
    }
  }
}
