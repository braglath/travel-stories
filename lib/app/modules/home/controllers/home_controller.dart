import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController nameController, passwordController;

  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  RxBool obscured = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    googleSign = GoogleSignIn();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() async {
    super.onReady();
    // ? using ever to keep looking for changes
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      // ? this event will contain the firebase user
      isSignIn.value = event != null;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
  }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      // todo if the user is logged in redirect user
      // todo we can check the database for user details aswell
      checkGoogleLogin();
      // loginUser(name, password)
      // Get.offAllNamed(Routes.SUBMIT_STORY, arguments: firebaseAuth.currentUser);
    } else {
      // Get.offAllNamed(Routes.INTRODUCTION);
    }
  }

  void loginGoogleSignIn() async {
    // todo inplement progress indicator first
    GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
    if (googleSignInAccount == null) {
      //? user is null cancel the loading
      CustomSnackbar(title: 'Error', message: 'Google Signin error')
          .showWarning();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await firebaseAuth.signInWithCredential(oAuthCredential);
      // ? now close the loding indicator
      name.value = firebaseAuth.currentUser!.displayName.toString();
      email.value = firebaseAuth.currentUser!.email.toString();
    }
  }

  void logoutGoogleSingIn() async {
    await googleSign.disconnect();
    await firebaseAuth.signOut();
  }

  String? validatePassword(String value) {
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
      loginUser(name.value, password.value);
    }
  }

  void checkGoogleLogin() async {
    var url = 'http://ubermensch.studio/travel_stories/googlelogin.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name.value,
      "phoneoremail": email.value,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    var details = json.decode(json.encode(res.body));
    print(res.body);

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
        // loginUser(name.value, password.value);
        CustomSnackbar(title: 'Login', message: 'Enter password to login')
            .showWarning();
      }
    } else {
      isLoading.value = false;
      CustomSnackbar(
              title: 'Login error', message: 'Check your internet connection')
          .showWarning();
      throw Exception();
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
