import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_diaries/app/data/Services/notification.dart';
import 'package:travel_diaries/app/data/storage/user_check_login_logout.dart';
import 'package:travel_diaries/app/data/theme/theme_data.dart';
import 'package:travel_diaries/app/modules/home/bindings/home_binding.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  NotificationService().scheduledNotification();
  await Firebase.initializeApp();
  // HomeBinding().dependencies();
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
