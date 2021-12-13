import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  late GoogleSignIn googleSign;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final args = Get.arguments;
  final count = 0.obs;
  RxString profilePicture = ''.obs;
  final scrollController = ScrollController().obs;
  var shouldAutoscroll = false.obs;

  @override
  void onInit() {
    super.onInit();
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
}
