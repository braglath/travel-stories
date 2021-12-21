import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class FacebookLogin {
  Future<dynamic> loginwithFacebook() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      UserLoginLogout().facebookUserLoggedIn(true);
      return userData;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          CustomSnackbar(
                  title: 'Account exists with different credential',
                  message: 'This account exists with google, try google login')
              .showWarning();
          break;
        case 'invalid-credential':
          CustomSnackbar(
                  title: 'Invalid credential',
                  message: 'Unknow error has occusred')
              .showWarning();
          break;
        case 'operation-not-allowed':
          CustomSnackbar(
                  title: 'Operation not allowed',
                  message: 'This operation is not allowed')
              .showWarning();
          break;
        case 'user-disabled':
          CustomSnackbar(
                  title: 'User disabled',
                  message: 'The user you tried to log into is diabled')
              .showWarning();
          break;
        case 'user-not-found':
          CustomSnackbar(
                  title: 'User not found',
                  message: 'The user you tried to log into was not found')
              .showWarning();
          break;
      }
      return null;
    } finally {}
  }

  Future<bool> logoutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
    UserLoginLogout().facebookUserLoggedIn(false);
    return true;
  }
}
