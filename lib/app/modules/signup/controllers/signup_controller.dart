import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/home/controllers/home_controller.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_bottom_sheet_view.dart';
import 'package:travel_diaries/app/views/views/custom_dialogue_view.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  // todo find the controller where the google signin method ever is listening

  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var name = ''.obs;
  var email = ''.obs;

  final count = 0.obs;
  final defaultChoiceIndex = 0.obs;
  RxBool isSelected = false.obs;
  RxBool obscured = true.obs;
  RxBool isLoading = false.obs;
  XFile? photo;

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
    googleSign = GoogleSignIn();
    super.onInit();
  }

  @override
  void onReady() async {
    // ? using ever to keep looking for changes
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      // ? this event will contain the firebase user
      isSignIn.value = event != null;
    });
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      // todo if the user is logged in redirect user
      // todo we can check the database for user details aswell
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
                message: 'Account already exists! Login now!')
            .showWarning();
        logoutGoogleSingIn();
        isLoading.value = false;
      }
      if (details.toString().contains("true")) {
        // todo show dialogue box
        loginUser(name, password);
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

  void loginUser(String name, String password) async {
    var url = 'http://ubermensch.studio/travel_stories/login.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name,
      "password": password,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    var details = json.decode(json.encode(res.body));

    if (res.statusCode == 200) {
      final List list = json.decode(res.body);
      isLoading.value = false;
      print('login main - Success');
      print('login list - $list');
      UserDetails().saveUserNametoBox(
        list[0]['name'],
      );
      UserDetails().saveUserPhoneorEmailtoBox(
        list[0]['phoneoremail'],
      );
      UserDetails().saveUserPasswordtoBox(
        list[0]['password'],
      );
      UserDetails().saveUserFavtoBox(
        list[0]['fav'],
      );
      UserDetails().saveUserIDtoBox(
        list[0]['id'],
      );
      // UserDetails().saveUserDetailstoBox(
      //     list[0]['name'],
      //     list[0]['phoneoremail'],
      //     list[0]['password'],
      //     list[0]['fav'],
      //     list[0]['profilepicture'],
      //     list[0]['id']);
      UserLoginLogout().userLoggedIn(true);
      CustomDialogue(
              title: 'Set a profile picture',
              textConfirm: 'Set now',
              textCancel: 'Set it later',
              onpressedConfirm: () => CustomBottomSheet(
                    icon1: FontAwesomeIcons.cameraRetro,
                    icon2: FontAwesomeIcons.photoVideo,
                    title1: 'Camera',
                    titile2: 'Gallery',
                    onTap1: () => pickImage(ImageSource.camera),
                    onTap2: () => pickImage(ImageSource.gallery),
                  ).show(),
              onpressedCancel: () => Get.offAllNamed(Routes.SUBMIT_STORY),
              contentWidget: dialogueContent())
          .showDialogue();
    } else {
      isLoading.value = false;
      throw Exception();
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final ImagePicker _picker = ImagePicker();
      photo = await _picker.pickImage(source: source);
      if (photo == null) {
        return;
      } else {
        // final imageTemporary = File(photo.path);
        photo = XFile(photo!.path);
        if (photo != null) {
          uploadProfileImageToDB();
        } else {
          throw Exception();
        }
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadProfileImageToDB() async {
    final uri = Uri.parse(
        "http://ubermensch.studio/travel_stories/addprofileimage.php");
    var request = http.MultipartRequest('POST', uri);
    print(UserDetails().readUserNamefromBox());
    print(UserDetails().readUserIDfromBox());
    print(UserDetails().readUserPasswordfromBox());
    request.fields['name'] = UserDetails().readUserNamefromBox();
    request.fields['id'] = UserDetails().readUserIDfromBox();
    var path = photo?.path;
    var pic = await http.MultipartFile.fromPath("image", path.toString());
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('more option page upload profile image to db imate path - $path');
      getUserDetails(UserDetails().readUserNamefromBox(),
          UserDetails().readUserPasswordfromBox());

      // fetchAllProducts(loginUserPhoneNumber);
    } else {}
  }

  void getUserDetails(String name, String password) async {
    print('get user details $name, $password');
    var url = 'http://ubermensch.studio/travel_stories/login.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name,
      "password": password,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    var details = json.decode(json.encode(res.body));
    print('json get user details ${jsonDecode(res.body)}');

    if (res.statusCode == 200) {
      final List list = json.decode(res.body);
      isLoading.value = false;
      print('login main - Success');
      UserDetails().saveUserDetailstoBox(
          list[0]['name'],
          list[0]['phoneoremail'],
          list[0]['password'],
          list[0]['fav'],
          list[0]['profilepicture'],
          list[0]['id']);
      Get.back();
      Get.offAllNamed(Routes.SUBMIT_STORY);
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
