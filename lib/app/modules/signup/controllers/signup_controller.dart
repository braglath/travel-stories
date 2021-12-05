import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_dialogue_view.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  final count = 0.obs;
  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;
  RxBool obscured = true.obs;
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

  bool isSelectedLabel() => isSelected.value = true;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void profilePictureDialogue(name, phoneoremail, password) {
    isLoading.value = true;
    if (name.toString() == '' ||
        phoneoremail.toString() == '' ||
        password.toString() == '') {
      CustomSnackbar(title: 'Warning', message: 'Credentials cannot be empty')
          .showWarning();
      isLoading.value = false;
    }
    if (defaultChoiceIndex.value == 0) {
      CustomSnackbar(
              title: 'Warning', message: 'Pick one favorite mode of transport')
          .showWarning();
      isLoading.value = false;
    } else {
      signupUser(name, phoneoremail, password);
    }
  }

  void signupUser(String name, String phoneoremail, String password) async {
    var url = 'http://ubermensch.studio/travel_stories/signup.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name,
      "phoneoremail": phoneoremail,
      "password": password,
      "fav": travelmodes[defaultChoiceIndex.value]
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    var details = json.decode(json.encode(res.body));
    if (res.statusCode == 200) {
      if (details.toString().contains("error")) {
        CustomSnackbar(
                title: 'User exists',
                message: 'Accouont already exists! Login now!')
            .showWarning();
        isLoading.value = false;
      }
      if (details.toString().contains("true")) {
        UserLoginLogout().userLoggedIn(true);
        UserDetails().saveUserDetailstoBox(name, phoneoremail, password,
            travelmodes[defaultChoiceIndex.value], '', '');
        CustomDialogue(
                title: 'Set a profile picture',
                textConfirm: 'Set now',
                textCancel: 'Set it later',
                onpressedConfirm: () {},
                onpressedCancel: () => Get.offAllNamed(Routes.SUBMIT_STORY),
                contentWidget: dialogueContent())
            .showDialogue();
        isLoading.value = false;
        print('true');
      }
      if (details.toString().contains("false")) {
        CustomSnackbar(
                title: 'Warning', message: 'Check your internet connection')
            .showWarning();
        isLoading.value = false;
        print('false');
      }
    } else {
      isLoading.value = false;
      throw Exception();
    }
  }
}

Widget dialogueContent() => Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: ColorResourcesLight.mainLIGHTColor,
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          UserDetails().readUserNamefromBox(),
          style: TextStyle(
            color: ColorResourcesLight.mainTextHEADINGColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          UserDetails().readUserPhoneorEmailfromBox(),
          style: TextStyle(
            color: ColorResourcesLight.mainTextHEADINGColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
