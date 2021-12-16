import 'package:get_storage/get_storage.dart';

class UserLoginLogout {
  final _box = GetStorage();
  final _googleUserbox = GetStorage();
  final _facebookUserbox = GetStorage();
  final _key = 'userLoggedIn';
  final _googleUserkey = 'googleUserLoggedIn';
  final _facebookUserkey = 'facebookUserLoggedIn';

  bool checkisUserLoggedIn() => _box.read(_key) ?? false;
  Future<void> userLoggedIn(bool userLoggedIn) =>
      _box.write(_key, userLoggedIn);

  bool isGoogleUserLoggedIn() => _box.read(_googleUserkey) ?? false;
  Future<void> googleUserLoggedIn(bool userLoggedIn) =>
      _googleUserbox.write(_googleUserkey, userLoggedIn);

  bool isFacebookUserLoggedIn() => _box.read(_facebookUserkey) ?? false;
  Future<void> facebookUserLoggedIn(bool userLoggedIn) =>
      _facebookUserbox.write(_facebookUserkey, userLoggedIn);
}
