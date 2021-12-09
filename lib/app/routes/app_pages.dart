import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/bindings/app_bar_binding.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/contact_us/bindings/contact_us_binding.dart';
import 'package:travel_diaries/app/modules/contact_us/views/contact_us_view.dart';
import 'package:travel_diaries/app/modules/fav_full_screen/bindings/fav_full_screen_binding.dart';
import 'package:travel_diaries/app/modules/fav_full_screen/views/fav_full_screen_view.dart';
import 'package:travel_diaries/app/modules/fave_stories/bindings/fave_stories_binding.dart';
import 'package:travel_diaries/app/modules/fave_stories/views/fave_stories_view.dart';
import 'package:travel_diaries/app/modules/full_screen_story/bindings/full_screen_story_binding.dart';
import 'package:travel_diaries/app/modules/full_screen_story/views/full_screen_story_view.dart';
import 'package:travel_diaries/app/modules/home/bindings/home_binding.dart';
import 'package:travel_diaries/app/modules/home/views/home_view.dart';
import 'package:travel_diaries/app/modules/my_stories/bindings/my_stories_binding.dart';
import 'package:travel_diaries/app/modules/my_stories/views/my_stories_view.dart';
import 'package:travel_diaries/app/modules/my_stories_full_screen/bindings/my_stories_full_screen_binding.dart';
import 'package:travel_diaries/app/modules/my_stories_full_screen/views/my_stories_full_screen_view.dart';
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

  static const NEWUSER = Routes.INTRODUCTION;
  static const OLDUSER = Routes.SUBMIT_STORY;

  static final routes = [
    GetPage(
        name: _Paths.INTRODUCTION,
        page: () => IntroductioScreensView(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic

        // binding: HomeBinding(),
        ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      // transition: Transition.rightToLeftWithFade,
      // transitionDuration: Duration(milliseconds: 600),
      // curve: Curves.fastOutSlowIn
    ),
    GetPage(
      name: _Paths.SUBMIT_STORY,
      page: () => SubmitStoryView(),
      binding: SubmitStoryBinding(),
      // transition: Transition.rightToLeftWithFade,
      // transitionDuration: Duration(milliseconds: 600),
      // curve: Curves.fastOutSlowIn
    ),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        // transition: Transition.rightToLeftWithFade,
        // transitionDuration: Duration(milliseconds: 600),
        // curve: Curves.fastOutSlowIn
        children: <GetPage>[
          GetPage(
            name: _Paths.FAVE_STORIES,
            page: () => FaveStoriesView(),
            binding: FaveStoriesBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.APP_BAR,
      page: () => AppBarView(title: ''),
      binding: AppBarBinding(),
      // transition: Transition.fadeIn,
      // transitionDuration: Duration(milliseconds: 600),
      // curve: Curves.fastOutSlowIn
    ),
    GetPage(
      name: _Paths.POST_STORY,
      page: () => PostStoryView(),
      binding: PostStoryBinding(),
      // transition: Transition.rightToLeftWithFade,
      // transitionDuration: Duration(milliseconds: 600),
      // curve: Curves.fastOutSlowIn
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
      // transition: Transition.rightToLeft,
      // transitionDuration: Duration(milliseconds: 600),
      // curve: Curves.fastOutSlowIn
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.FULL_SCREEN_STORY,
      page: () => FullScreenStoryView(),
      binding: FullScreenStoryBinding(),
    ),
    GetPage(
      name: _Paths.FAVE_STORIES,
      page: () => FaveStoriesView(),
      binding: FaveStoriesBinding(),
    ),
    GetPage(
      name: _Paths.FAV_FULL_SCREEN,
      page: () => FavFullScreenView(),
      binding: FavFullScreenBinding(),
    ),
    GetPage(
      name: _Paths.MY_STORIES,
      page: () => MyStoriesView(),
      binding: MyStoriesBinding(),
    ),
    GetPage(
      name: _Paths.MY_STORIES_FULL_SCREEN,
      page: () => MyStoriesFullScreenView(),
      binding: MyStoriesFullScreenBinding(),
    ),
  ];
}
