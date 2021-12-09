import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_stories_full_screen_controller.dart';

class MyStoriesFullScreenView extends GetView<MyStoriesFullScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyStoriesFullScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyStoriesFullScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
