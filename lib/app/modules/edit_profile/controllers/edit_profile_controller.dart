import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      passwordController;
  var name;
  var email;
  var password;
  var profileImage = ''.obs;
  XFile? photo;
  final defaultChoiceIndex = 0.obs;
  RxBool obscured = true.obs;
  var isLoading = false.obs;

  List<String> travelmodes =
      ['Cycle', 'Bike', 'Car', 'Bus', 'Train', 'Flight'].obs;

  List<IconData> travelIcons = [
    Icons.directions_bike_sharp,
    Icons.motorcycle_rounded,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.train,
    Icons.flight_takeoff,
  ].obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    profileImage.value = UserDetails().readUserProfilePicfromBox();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      loginFormKey.currentState?.save();
      // loginUser(name, password);
    }
  }

  Future pickImage(ImageSource source) async {
    isLoading.value = true;
    try {
      final ImagePicker _picker = ImagePicker();
      photo = await _picker.pickImage(source: source);
      if (photo == null) {
        isLoading.value = false;
      } else {
        // final imageTemporary = File(photo.path);
        photo = XFile(photo!.path);
        if (photo != null) {
          uploadProfileImageToDB();
        } else {
          CustomSnackbar(title: 'Warning', message: 'Failed to pick image')
              .showWarning();
          isLoading.value = false;

          throw Exception();
        }
      }
    } on PlatformException catch (e) {
      isLoading.value = false;

      CustomSnackbar(title: 'Warning', message: 'Failed to pick image')
          .showWarning();
      print('Failed to pick image: $e');
    }
  }

  Future uploadProfileImageToDB() async {
    final uri = Uri.parse(
        "http://ubermensch.studio/travel_stories/addprofileimage.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = UserDetails().readUserNamefromBox();
    request.fields['id'] = UserDetails().readUserIDfromBox();
    var path = photo?.path;
    var pic = await http.MultipartFile.fromPath("image", path.toString());
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('till here 1');
      saveProfilePicToStories();
    } else {
      isLoading.value = false;

      print('error uploading photos to database');
    }
  }

  Future saveProfilePicToStories() async {
    final uri = Uri.parse(
        "http://ubermensch.studio/travel_stories/storiesprofilepic.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['personname'] = UserDetails().readUserNamefromBox();
    request.fields['personid'] = UserDetails().readUserIDfromBox();
    var path = photo?.path;
    var pic = await http.MultipartFile.fromPath("image", path.toString());
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('till here 2');
      getUserDetails();
    } else {
      isLoading.value = false;

      print('error uploading photos to database');
    }
  }

  void getUserDetails() async {
    var url = 'http://ubermensch.studio/travel_stories/login.php';
    var uri = Uri.parse(url);
    var data = {
      "name": UserDetails().readUserNamefromBox(),
      "password": UserDetails().readUserPasswordfromBox(),
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    if (res.statusCode == 200) {
      isLoading.value = false;
      print('till here 3');
      final List list = json.decode(res.body);
      print(list);
      UserDetails().saveUserNametoBox(list[0]['name']);
      UserDetails().saveUserPhoneorEmailtoBox(list[0]['phoneoremail']);
      UserDetails().saveUserPasswordtoBox(list[0]['password']);
      UserDetails().saveUserFavtoBox(list[0]['fav']);
      UserDetails().saveUserIDtoBox(list[0]['id']);
      UserDetails().saveUserProfilePictoBox(list[0]['profilepicture']);
      profileImage.value = UserDetails().readUserProfilePicfromBox();
      Get.back();

      CustomSnackbar(title: 'Success', message: "Profile image updated")
          .showSuccess();
    } else {
      isLoading.value = false;

      throw Exception();
    }
  }

  void saveUserDetails() async {
    isLoading.value = true;
    var url = 'http://ubermensch.studio/travel_stories/editusers.php';
    var uri = Uri.parse(url);
    var data = {
      "id": UserDetails().readUserIDfromBox(),
      "name": nameController.text,
      "phoneoremail": emailController.text,
      "password": passwordController.text,
      "fav": travelmodes[defaultChoiceIndex.value],
    };
    print(data);
    http.Response res = await http.post(Uri.parse(url), body: data);
    if (res.statusCode == 200) {
      getUserDetails2(nameController.text, passwordController.text);
    } else {
      isLoading.value = false;
      throw Exception();
    }
  }

  void getUserDetails2(String name, String password) async {
    var url = 'http://ubermensch.studio/travel_stories/login.php';
    var uri = Uri.parse(url);
    var data = {
      "name": name,
      "password": password,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    if (res.statusCode == 200) {
      isLoading.value = false;
      print('till here 3');
      final List list = json.decode(res.body);
      print(list);
      UserDetails().saveUserNametoBox(list[0]['name']);
      UserDetails().saveUserPhoneorEmailtoBox(list[0]['phoneoremail']);
      UserDetails().saveUserPasswordtoBox(list[0]['password']);
      UserDetails().saveUserFavtoBox(list[0]['fav']);
      UserDetails().saveUserIDtoBox(list[0]['id']);
      UserDetails().saveUserProfilePictoBox(list[0]['profilepicture']);
      profileImage.value = UserDetails().readUserProfilePicfromBox();
      Get.back();

      CustomSnackbar(title: 'Success', message: "Profile updated successfully")
          .showSuccess();
    } else {
      isLoading.value = false;

      throw Exception();
    }
  }
}
