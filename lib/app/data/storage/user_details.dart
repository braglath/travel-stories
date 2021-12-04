import 'package:get_storage/get_storage.dart';

class UserDetails {
  final _userNameBox = GetStorage();
  final _userEmailBox = GetStorage();
  final _userPhoneNumberBox = GetStorage();
  final _userPasswordBox = GetStorage();

  final _userNamekey = 'userName';
  final _userEmailkey = 'userEmail';
  final _userPhoneNumberkey = 'userPhoneNumber';
  final _userPasswordkey = 'userPassword';

  // ? write user details

  saveUserNametoBox(String userName) =>
      _userNameBox.write(_userNamekey, userName);

  saveUserEmailtoBox(String userEmail) =>
      _userNameBox.write(_userEmailkey, userEmail);

  saveUserPhonenumbertoBox(String userPhoneNumber) =>
      _userNameBox.write(_userPhoneNumberkey, _userPhoneNumberkey);

  saveUserPasswordtoBox(String userPassword) =>
      _userNameBox.write(_userPasswordkey, _userPasswordkey);

  // ? read user details

  String readUserNamefromBox() => _userNameBox.read(_userNamekey);
  String readUserEmailfromBox() => _userEmailBox.read(_userEmailkey);
  String readUserPhoneNumberfromBox() =>
      _userPhoneNumberBox.read(_userPhoneNumberkey);
  String readUserPasswordfromBox() => _userPasswordBox.read(_userPasswordkey);

  deleteUserDetailsfromBox() {
    _userNameBox.remove(_userNamekey);
    _userEmailBox.remove(_userEmailkey);
    _userPhoneNumberBox.remove(_userPhoneNumberkey);
    _userPasswordBox.remove(_userPasswordkey);
  }
}
