import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final args = Get.arguments;
  @override
  // final controller = Get.find(tag: 'profilecontroller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: 'Profile Page',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                'go to home',
              ),
              onPressed: () => Get.offAllNamed(Routes.HOME),
            ),
          ],
        ),
      ),
    );
  }
}
