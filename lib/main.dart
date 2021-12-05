import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/theme/theme_data.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      title: "Travel Stories",
      initialRoute: UserLoginLogout().checkisUserLoggedIn() == false
          ? AppPages.NEWUSER
          : AppPages.OLDUSER,
      getPages: AppPages.routes,
      theme: Themes.light,
      darkTheme: Themes.dark,
      debugShowCheckedModeBanner: false,
    ),
  );
}
