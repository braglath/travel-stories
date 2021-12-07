import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController nameController, passwordController;
  var name;
  var password;

  RxBool obscured = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
  }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name cannot empty';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot empty';
    }
    if (value.length < 4) {
      return 'Password cannot be less than 4 characters';
    }
    return null;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      loginFormKey.currentState?.save();
      loginUser(name, password);
    }
  }

  void loginUser(String name, String password) async {
    isLoading.value = true;
    var url = 'http://ubermensch.studio/travel_stories/login.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name,
      "password": password,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    var details = json.decode(json.encode(res.body));

    if (res.statusCode == 200) {
      print('login status code - ${res.statusCode}');

      if (details.toString().contains("Error")) {
        print('login main - Error');
        isLoading.value = false;
        CustomSnackbar(
                title: 'Login error',
                message: 'Mutiple users detected with the same name')
            .showWarning();
      } else if (details.toString().contains("new user")) {
        print('new user');
        isLoading.value = false;
        CustomSnackbar(
                title: 'Login error',
                message: 'Credentials are new here! Sign up')
            .showWarning();
      } else {
        final List list = json.decode(res.body);
        print('login user details list - $list');

        print('login main - Success');
        isLoading.value = false;
        UserDetails().saveUserDetailstoBox(
            list[0]['name'],
            list[0]['phoneoremail'],
            list[0]['password'],
            list[0]['fav'],
            list[0]['profilepicture'],
            list[0]['id']);
        UserLoginLogout().userLoggedIn(true);
        CustomSnackbar(
                title: 'Login Successful',
                message: 'Hello, ${UserDetails().readUserNamefromBox()}')
            .showSuccess();
        Get.offAllNamed(Routes.SUBMIT_STORY);
      }
    } else {
      isLoading.value = false;
      CustomSnackbar(
              title: 'Login error', message: 'Check your internet connection')
          .showWarning();
      throw Exception();
    }
  }

  void anonymousLogin() {
    isLoading.value = false;
    UserDetails().saveUserDetailstoBox(
        'Anonymous user',
        'Anonymous phone number',
        'Anonymous password',
        'bike',
        'profilepicture',
        'id');
    UserLoginLogout().userLoggedIn(true);
    CustomSnackbar(
            title: 'Anonymous login Successful',
            message: 'Hello, ${UserDetails().readUserNamefromBox()}')
        .showSuccess();
    Get.offAllNamed(Routes.SUBMIT_STORY);
  }
}
