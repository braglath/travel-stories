import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Models/stories_model.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/views/views/custom_dialogue_view.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';
import 'package:travel_diaries/main.dart';

class SubmitStoryController extends GetxController {
  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;
  RxBool isLiked = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isLoading = false.obs;
  final scrollController = ScrollController().obs;
  var shouldAutoscroll = false.obs;
  DateTime timeBackButtonPressed = DateTime.now();
  // final animatedHeight = 0.obs;
  // final isLarge = false.obs;

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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    color: ColorResourcesLight.mainLIGHTColor,
                    playSound: true,
                    enableLights: true,
                    enableVibration: true,
                    priority: Priority.high,
                    icon: '@mipmap/launcher_icon')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        CustomSnackbar(
                title: 'Success',
                message: 'Welcome back, ${UserDetails().readUserNamefromBox()}')
            .showSuccess();
      }
    });
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
      story.assignAll(stories);
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
