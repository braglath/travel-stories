import 'package:get_storage/get_storage.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';

class UserDetails {
  final _userNameBox = GetStorage();
  final _userPhoneorEmailBox = GetStorage();
  final _userPasswordBox = GetStorage();
  final _userFavBox = GetStorage();
  final _userProfilePicBox = GetStorage();
  final _userIDBox = GetStorage();

  final _userNamekey = 'userName';
  final _userPhoneorEmailkey = 'userPhoneNumber';
  final _userPasswordkey = 'userPassword';
  final _userFavkey = 'userFav';
  final _userProfilePickey = 'userProfilePic';
  final _userIDkey = 'userID';

  // ? write user details

  saveUserNametoBox(String userName) =>
      _userNameBox.write(_userNamekey, userName);

  saveUserPhoneorEmailtoBox(String userPhoneorEmail) =>
      _userPhoneorEmailBox.write(_userPhoneorEmailkey, userPhoneorEmail);

  saveUserPasswordtoBox(String userPassword) =>
      _userPasswordBox.write(_userPasswordkey, _userPasswordkey);

  saveUserFavtoBox(String userFav) => _userFavBox.write(_userFavkey, userFav);

  saveUserProfilePictoBox(String userProfilePic) =>
      _userProfilePicBox.write(_userProfilePickey, userProfilePic);

  saveUserIDtoBox(String userID) => _userIDBox.write(_userIDkey, userID);

  // ? read user details

  String readUserNamefromBox() => _userNameBox.read(_userNamekey);
  String readUserPhoneorEmailfromBox() =>
      _userPhoneorEmailBox.read(_userPhoneorEmailkey);
  String readUserPasswordfromBox() => _userPasswordBox.read(_userPasswordkey);
  String readUserFavfromBox() => _userFavBox.read(_userFavkey);
  String readUserProfilePicfromBox() =>
      _userPasswordBox.read(_userProfilePickey);
  String readUserIDfromBox() => _userIDBox.read(_userIDkey);

  deleteUserDetailsfromBox() {
    _userNameBox.remove(_userNamekey);
    _userPhoneorEmailBox.remove(_userPhoneorEmailkey);
    _userPasswordBox.remove(_userPasswordkey);
    _userFavBox.remove(_userFavkey);
    _userProfilePicBox.remove(_userProfilePickey);
    _userIDBox.remove(_userIDkey);
    UserLoginLogout().userLoggedIn(false);
  }

  saveUserDetailstoBox(String name, String phoneoremail, String password,
      String fav, String profilepic, String id) {
    saveUserNametoBox(name);
    saveUserPhoneorEmailtoBox(phoneoremail);
    saveUserPasswordtoBox(password);
    saveUserFavtoBox(fav);
    saveUserProfilePictoBox(profilepic);
    saveUserIDtoBox(profilepic);
  }
}
