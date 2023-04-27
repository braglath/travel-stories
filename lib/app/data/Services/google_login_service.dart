import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class GoogleLogin {
  GoogleSignIn googleSign = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> loginGoogleSignIn() async {
    // todo implement progress indicator first
    User? user;
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
      user = firebaseAuth.currentUser;
    }
    return user;
  }

  Future<bool> logoutFromGoogle() async {
    await googleSign.disconnect();
    await firebaseAuth.signOut();
    UserLoginLogout().googleUserLoggedIn(false);
    return true;
  }
}
