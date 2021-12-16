import 'package:get/get.dart';
import 'package:travel_diaries/app/data/Services/facebook_login_service.dart';
import 'package:travel_diaries/app/data/Services/google_login_service.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';

class LogoutUserFromAll {
  void now() async {
    Get.reloadAll(force: true);
    UserLoginLogout().userLoggedIn(false);
    GoogleLogin().logoutFromGoogle();
    FacebookLogin().logoutFromFacebook();
    UserDetails().deleteUserDetailsfromBox();
    Get.offAllNamed(Routes.HOME);
  }
}
