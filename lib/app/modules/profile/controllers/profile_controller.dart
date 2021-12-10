import 'package:firebase_auth/firebase_auth.dart';
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
  @override
  void onInit() {
    super.onInit();
    profilePicture.value = UserDetails().readUserProfilePicfromBox();
  }

  @override
  void onReady() {
    googleSign = GoogleSignIn();
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count + 15;
  void onTapped() => count.value++;
  
  void logoutGoogleUser() async {
    await googleSign.disconnect();
    await firebaseAuth.signOut();
  }
}
