import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:travel_diaries/app/modules/app_bar/bindings/app_bar_binding.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/chat_room/bindings/chat_room_binding.dart';
import 'package:travel_diaries/app/modules/chat_room/views/chat_room_view.dart';
import 'package:travel_diaries/app/modules/contact_us/bindings/contact_us_binding.dart';
import 'package:travel_diaries/app/modules/contact_us/views/contact_us_view.dart';
import 'package:travel_diaries/app/modules/edit_my_stories/bindings/edit_my_stories_binding.dart';
import 'package:travel_diaries/app/modules/edit_my_stories/views/edit_my_stories_view.dart';
import 'package:travel_diaries/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:travel_diaries/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:travel_diaries/app/modules/fav_full_screen/bindings/fav_full_screen_binding.dart';
import 'package:travel_diaries/app/modules/fav_full_screen/views/fav_full_screen_view.dart';
import 'package:travel_diaries/app/modules/fave_stories/bindings/fave_stories_binding.dart';
import 'package:travel_diaries/app/modules/fave_stories/views/fave_stories_view.dart';
import 'package:travel_diaries/app/modules/full_screen_story/bindings/full_screen_story_binding.dart';
import 'package:travel_diaries/app/modules/full_screen_story/views/full_screen_story_view.dart';
import 'package:travel_diaries/app/modules/home/bindings/home_binding.dart';
import 'package:travel_diaries/app/modules/home/views/home_view.dart';
import 'package:travel_diaries/app/modules/loading_chat_room/bindings/loading_chat_room_binding.dart';
import 'package:travel_diaries/app/modules/loading_chat_room/views/loading_chat_room_view.dart';
import 'package:travel_diaries/app/modules/my_stories/bindings/my_stories_binding.dart';
import 'package:travel_diaries/app/modules/my_stories/views/my_stories_view.dart';
import 'package:travel_diaries/app/modules/my_stories_full_screen/bindings/my_stories_full_screen_binding.dart';
import 'package:travel_diaries/app/modules/my_stories_full_screen/views/my_stories_full_screen_view.dart';
import 'package:travel_diaries/app/modules/my_tabs/bindings/my_tabs_binding.dart';
import 'package:travel_diaries/app/modules/my_tabs/views/my_tabs_view.dart';
import 'package:travel_diaries/app/modules/navigation_drawer/bindings/navigation_drawer_binding.dart';
import 'package:travel_diaries/app/modules/navigation_drawer/views/navigation_drawer_view.dart';
import 'package:travel_diaries/app/modules/other_profile/bindings/other_profile_binding.dart';
import 'package:travel_diaries/app/modules/other_profile/views/other_profile_view.dart';
import 'package:travel_diaries/app/modules/post_story/bindings/post_story_binding.dart';
import 'package:travel_diaries/app/modules/post_story/views/post_story_view.dart';
import 'package:travel_diaries/app/modules/privacy_policy/bindings/privacy_policy_binding.dart';
import 'package:travel_diaries/app/modules/privacy_policy/views/privacy_policy_view.dart';
import 'package:travel_diaries/app/modules/profile/bindings/profile_binding.dart';
import 'package:travel_diaries/app/modules/profile/views/profile_view.dart';
import 'package:travel_diaries/app/modules/signup/bindings/signup_binding.dart';
import 'package:travel_diaries/app/modules/signup/views/signup_view.dart';
import 'package:travel_diaries/app/modules/submit_story/bindings/submit_story_binding.dart';
import 'package:travel_diaries/app/modules/submit_story/views/submit_story_view.dart';
import 'package:travel_diaries/app/modules/theme_selection/bindings/theme_selection_binding.dart';
import 'package:travel_diaries/app/modules/theme_selection/views/theme_selection_view.dart';
import 'package:travel_diaries/app/modules/top_stories/bindings/top_stories_binding.dart';
import 'package:travel_diaries/app/modules/top_stories/views/top_stories_view.dart';
import 'package:travel_diaries/app/views/views/introductio_screens_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const NEWUSER = Routes.THEME_SELECTION;
  static const OLDUSER = Routes.NAVIGATION_DRAWER;

  static final routes = [
    GetPage(
        name: _Paths.INTRODUCTION,
        page: () => IntroductioScreensView(),
        transition: Transition.downToUp,
        transitionDuration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn

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
      page: () => AppBarView(appBarSize: 56, bottom: null, title: ''),
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
    GetPage(
      name: _Paths.EDIT_MY_STORIES,
      page: () => EditMyStoriesView(),
      binding: EditMyStoriesBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.TOP_STORIES,
      page: () => TopStoriesView(),
      binding: TopStoriesBinding(),
    ),
    GetPage(
      name: _Paths.OTHER_PROFILE,
      page: () => OtherProfileView(),
      binding: OtherProfileBinding(),
    ),
    GetPage(
      name: _Paths.MY_TABS,
      page: () => MyTabsView(),
      binding: MyTabsBinding(),
    ),
    GetPage(
        name: _Paths.CHAT_ROOM,
        page: () => ChatRoomView(),
        binding: ChatRoomBinding(),
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 600)),
    GetPage(
        name: _Paths.LOADING_CHAT_ROOM,
        page: () => LoadingChatRoomView(),
        binding: LoadingChatRoomBinding(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(seconds: 1)),
    GetPage(
      name: _Paths.NAVIGATION_DRAWER,
      page: () => NavigationDrawerView(),
      binding: NavigationDrawerBinding(),
    ),
    GetPage(
        name: _Paths.THEME_SELECTION,
        page: () => ThemeSelectionView(),
        binding: ThemeSelectionBinding(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
  ];
}
