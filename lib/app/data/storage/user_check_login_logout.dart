import 'package:get_storage/get_storage.dart';

class UserLoginLogout {
  final _box = GetStorage();
  final _key = 'userLoggedIn';

  bool checkisUserLoggedIn() => _box.read(_key) ?? false;
  Future<void> userLoggedIn(bool userLoggedIn) =>
      _box.write(_key, userLoggedIn);
}
