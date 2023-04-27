import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/Models/author_details_model.dart';
import 'package:travel_diaries/app/data/Models/my_stories_model.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';

class ProfileController extends GetxController {
  late GoogleSignIn googleSign;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final args = Get.arguments;
  final count = 0.obs;
  RxString profilePicture = ''.obs;
  final scrollController = ScrollController().obs;
  var shouldAutoscroll = false.obs;
  var storiesPosted = <MyStoriesModel>[].obs;
  var authorDetails = <AuthorDetailsModel>[].obs;

  var totallikes = 0.obs;
  final isLoading = false.obs;

  // ? profile details
// ?

  @override
  void onInit() {
    super.onInit();
    addStoriedPosted();
    profilePicture.value = UserDetails().readUserProfilePicfromBox();
    scrollController.value.addListener(_scrollListener);
  }

  @override
  void onReady() {
    googleSign = GoogleSignIn();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.value.removeListener(_scrollListener);
  }

  void increment() => count + 15;
  void onTapped() => count.value++;

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

  void logoutGoogleUser() async {
    await googleSign.disconnect();
    await firebaseAuth.signOut();
  }

  Future<List<MyStoriesModel>> getStoriesPosted() async {
    isLoading.value = true;
    var url = 'http://ubermensch.studio/travel_stories/getmystories.php';
    var data = {
      'personid': UserDetails().readUserIDfromBox(),
      'personname': UserDetails().readUserNamefromBox()
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      isLoading.value = false;

      var jsonString = res.body;
      print(jsonString);

      return myStoriesModelFromJson(jsonString);
    } else {
      isLoading.value = false;

      throw Exception();
    }
  }

  void addStoriedPosted() async {
    var storydetails = await getStoriesPosted();
    storiesPosted.assignAll(storydetails);
    totalLikes();
  }

  void totalLikes() {
    for (var i = 0; i < storiesPosted.length; i++) {
      totallikes.value += int.parse(storiesPosted[i].likes);
    }
    print('total likes : ${totallikes.value}');
  }
}
