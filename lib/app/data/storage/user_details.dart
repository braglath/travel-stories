import 'package:get_storage/get_storage.dart';

import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';

class UserDetails {
  final _userNameBox = GetStorage();
  final _userPhoneorEmailBox = GetStorage();
  final _userPasswordBox = GetStorage();
  final _userFavBox = GetStorage();
  final _userProfilePicBox = GetStorage();
  final _userCaptionBox = GetStorage();
  final _userIDBox = GetStorage();

  final _userNamekey = 'userName';
  final _userPhoneorEmailkey = 'userPhoneNumber';
  final _userPasswordkey = 'userPassword';
  final _userFavkey = 'userFav';
  final _userProfilePickey = 'userProfilePic';
  final _userCaptionKey = 'userCaption';
  final _userIDkey = 'userID';

  // ? write user details

  saveUserNametoBox(String userName) =>
      _userNameBox.write(_userNamekey, userName);

  saveUserPhoneorEmailtoBox(String userPhoneorEmail) =>
      _userPhoneorEmailBox.write(_userPhoneorEmailkey, userPhoneorEmail);

  saveUserPasswordtoBox(String userPassword) =>
      _userPasswordBox.write(_userPasswordkey, userPassword);

  saveUserFavtoBox(String userFav) => _userFavBox.write(_userFavkey, userFav);

  saveUserProfilePictoBox(String userProfilePic) =>
      _userProfilePicBox.write(_userProfilePickey, userProfilePic);

  saveUserCaptiontoBox(String userCaption) =>
      _userCaptionBox.write(_userCaptionKey, userCaption);

  saveUserIDtoBox(String userID) => _userIDBox.write(_userIDkey, userID);

  // ? read user details

  String readUserNamefromBox() => _userNameBox.read(_userNamekey);
  String readUserPhoneorEmailfromBox() =>
      _userPhoneorEmailBox.read(_userPhoneorEmailkey);
  String readUserPasswordfromBox() => _userPasswordBox.read(_userPasswordkey);
  String readUserFavfromBox() => _userFavBox.read(_userFavkey);
  String readUserProfilePicfromBox() =>
      _userProfilePicBox.read(_userProfilePickey);
  String readUserCaptionfromBox() => _userCaptionBox.read(_userCaptionKey);
  String readUserIDfromBox() => _userIDBox.read(_userIDkey);

  void deleteUserDetailsfromBox() {
    _userNameBox.erase();
    _userPhoneorEmailBox.erase();
    _userPasswordBox.erase();
    _userFavBox.erase();
    _userProfilePicBox.erase();
    _userCaptionBox.erase();
    _userIDBox.erase();
    UserLoginLogout().userLoggedIn(false);
  }

  saveUserDetailstoBox(
      {required String name,
      required String phoneoremail,
      required String password,
      required String fav,
      required String profilepic,
      required String caption,
      required String id}) {
    saveUserNametoBox(name);
    saveUserPhoneorEmailtoBox(phoneoremail);
    saveUserPasswordtoBox(password);
    saveUserFavtoBox(fav);
    saveUserProfilePictoBox(profilepic);
    saveUserCaptiontoBox(caption);
    saveUserIDtoBox(id);
  }
}
