import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Services/facebook_login_service.dart';
import 'package:travel_diaries/app/data/Services/logout_user_service.dart';

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
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
  }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void facebookLogin() async {
    isLoading.value = true;
    var userData = await FacebookLogin()
        .loginwithFacebook()
        .whenComplete(() => isLoading.value = false);
    if (userData != null) {
      name.value = '${userData['name']}';
      email.value = '${userData['email']}';
      loginGoogleUser();
    } else {
      isLoading.value = false;
      return null;
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
      loginGoogleUser();
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

  // void checkGoogleLogin() async {
  //   var url = 'http://ubermensch.studio/travel_stories/googlelogin.php';
  //   var data = {
  //     "name": name.value,
  //     "phoneoremail": email.value,
  //   };

  //   http.Response res = await http.post(Uri.parse(url), body: data);
  //   var details = json.decode(json.encode(res.body));
  //   print(res.body);

  //   if (res.statusCode == 200) {
  //     print('login status code - ${res.statusCode}');

  //     if (details.toString().contains("Error")) {
  //       print('login main - Error');
  //       isLoading.value = false;
  //       CustomSnackbar(
  //               title: 'Login error',
  //               message: 'Mutiple users detected with the same name')
  //           .showWarning();
  //     }
  //     if (details.toString().contains("new user")) {
  //       print('new user');
  //       isLoading.value = false;
  //       CustomSnackbar(
  //               title: 'Login error',
  //               message: 'Credentials are new here! Sign up')
  //           .showWarning();
  //     } else {
  //       final List list = json.decode(res.body);
  //       print('login user details list - $list');

  //       print('login main - Success');
  //       // loginUser(name.value, password.value);
  //       loginGoogleUser();
  //       // CustomSnackbar(title: 'Login', message: 'Enter password to login')
  //       //     .showWarning();
  //     }
  //   } else {
  //     isLoading.value = false;
  //     CustomSnackbar(
  //             title: 'Login error', message: 'Check your internet connection')
  //         .showWarning();
  //     throw Exception();
  //   }
  // }

  void loginGoogleUser() async {
    isLoading.value = true;
    var url = 'http://ubermensch.studio/travel_stories/logingoogleuser.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name.value,
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
            name: list[0]['name'],
            phoneoremail: list[0]['phoneoremail'],
            password: list[0]['password'],
            fav: list[0]['fav'],
            profilepic: list[0]['profilepicture'].toString(),
            caption: list[0]['caption'],
            id: list[0]['id']);
        UserLoginLogout().userLoggedIn(true);
        // UserLoginLogout().googleUserLoggedIn(true);
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
            name: name,
            phoneoremail: list[0]['phoneoremail'],
            password: list[0]['password'],
            fav: list[0]['fav'],
            profilepic: list[0]['profilepicture'].toString(),
            caption: list[0]['caption'],
            id: list[0]['id']);
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
        name: 'Anonymous user',
        phoneoremail: 'Anonymous phone',
        password: 'anonymusr',
        fav: 'Bike',
        profilepic: 'Profile picture',
        caption: 'I am an anonymous user',
        id: '555');
    UserLoginLogout().userLoggedIn(true);
    CustomSnackbar(
            title: 'Anonymous login Successful',
            message: 'Hello, ${UserDetails().readUserNamefromBox()}')
        .showSuccess();
    Get.offAllNamed(Routes.SUBMIT_STORY);
  }
}
