import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/bindings/app_bar_binding.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/home/bindings/home_binding.dart';
import 'package:travel_diaries/app/modules/home/views/home_view.dart';
import 'package:travel_diaries/app/modules/post_story/bindings/post_story_binding.dart';
import 'package:travel_diaries/app/modules/post_story/views/post_story_view.dart';
import 'package:travel_diaries/app/modules/profile/bindings/profile_binding.dart';
import 'package:travel_diaries/app/modules/profile/views/profile_view.dart';
import 'package:travel_diaries/app/modules/signup/bindings/signup_binding.dart';
import 'package:travel_diaries/app/modules/signup/views/signup_view.dart';
import 'package:travel_diaries/app/modules/submit_story/bindings/submit_story_binding.dart';
import 'package:travel_diaries/app/modules/submit_story/views/submit_story_view.dart';
import 'package:travel_diaries/app/views/views/introductio_screens_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRODUCTION;

  static final routes = [
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductioScreensView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUBMIT_STORY,
      page: () => SubmitStoryView(),
      binding: SubmitStoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.APP_BAR,
      page: () => AppBarView(
        title: '',
      ),
      binding: AppBarBinding(),
    ),
    GetPage(
      name: _Paths.POST_STORY,
      page: () => PostStoryView(),
      binding: PostStoryBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
  ];
}
