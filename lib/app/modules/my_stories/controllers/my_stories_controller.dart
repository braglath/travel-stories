import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/Models/my_stories_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class MyStoriesController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  List<MyStoriesModel> story = <MyStoriesModel>[].obs;
  final scrollController = ScrollController().obs;
  var shouldAutoscroll = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyStories();
    scrollController.value.addListener(_scrollListener);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.value.removeListener(_scrollListener);
  }

  void increment() => count.value++;

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

  void fetchMyStories() async {
    isLoading.value = true;

    var stories = await APIservices.fetchMyStories();

    if (stories.isNotEmpty) {
      story.assignAll(stories);
      isLoading.value = false;
    } else {
      print('Nothing to show');
      isLoading.value = false;
    }
  }

  Future<List<MyStoriesModel>> refreshMyStories() async {
    var stories = await APIservices.fetchMyStories();
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

  void removeStory(
      {required id,
      required personid,
      required personname,
      required MyStoriesModel storiesIndex}) async {
    var url = 'http://ubermensch.studio/travel_stories/removemystories.php';
    var uri = Uri.parse(url);
    var data = {
      "id": id,
      "personid": personid,
      "personname": personname,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains("Story deleted successfully")) {
      // todo change stories table in sql
      print('success');
      story.remove(storiesIndex);
      CustomSnackbar(
              title: 'Success',
              message: 'Successfully removed the story from your Myorites list')
          .showSuccess();
    } else {
      print('error');
      CustomSnackbar(
              title: 'Warning',
              message: 'Error removing story from your Myorites list')
          .showWarning();
    }
  }
}
