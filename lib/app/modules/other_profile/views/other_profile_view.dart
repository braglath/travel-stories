import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/top_to_bottom_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';
import 'package:travel_diaries/app/modules/profile/controllers/profile_controller.dart';
import 'package:travel_diaries/app/modules/submit_story/controllers/submit_story_controller.dart';
import 'package:travel_diaries/app/modules/top_stories/views/top_stories_view.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_counter.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';
import 'package:travel_diaries/app/views/views/custom_story_bar_widget_view.dart';

import '../controllers/other_profile_controller.dart';

class OtherProfileView extends GetView<OtherProfileController> {
  final CarouselController _controller = CarouselController();
  final profileController = Get.put<ProfileController>(ProfileController());
  final data = Get.arguments;
  String get authorId => data['authorId'];
  String get authorName => data['authorName'];

  @override
  Widget build(BuildContext context) {
    print('$authorId, $authorName');
    controller.addAuthorDetails(authorId, authorName);
    controller.addStoriedPosted(authorId, authorName);
    return Scaffold(
      bottomSheet: recentStories(context),
      appBar: AppBarView(
        title: '',
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            ToptoBottomAnimation(
              child: profilePic(),
              duration: Duration(milliseconds: 600),
            ),
            SizedBox(
              height: 10,
            ),
            nameandId(context),
            SizedBox(
              height: 10,
            ),
            cards(context),
          ],
        );
      }),
    );
  }

  Widget profilePic() {
    return Obx(() {
      return controller.authProfilePic.value.isEmpty
          ? CircleAvatar(
              radius: 50,
              backgroundColor: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTColor
                  : ColorResourcesDark.mainDARKColor,
              child: Icon(Icons.person))
          : Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: ThemeService().theme == ThemeMode.light
                        ? ColorResourcesLight.mainLIGHTColor
                        : ColorResourcesDark.mainDARKColor,
                    radius: 55,
                    child: CircleAvatar(
                        radius: 52.0,
                        child: controller.authProfilePic.value.isNotEmpty
                            ? null
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                        backgroundColor:
                            controller.authProfilePic.value.isNotEmpty
                                ? ThemeService().theme == ThemeMode.light
                                    ? ColorResourcesLight.mainLIGHTColor
                                    : ColorResourcesDark.mainDARKColor
                                : null,
                        backgroundImage: controller
                                .authProfilePic.value.isNotEmpty
                            ? NetworkImage(
                                "http://ubermensch.studio/travel_stories/profileimages/${controller.authProfilePic}")
                            : null),
                  ),
                ],
              ),
            );
    });
  }

  Widget nameandId(context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '${controller.authName.value} \n',
        style: Theme.of(context).textTheme.headline3,
        children: <TextSpan>[
          TextSpan(
              text: controller.authCaption.value,
              style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }

  Widget cards(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [totalStoriesPosted(context), totalLikedStories(context)],
    );
  }

  Widget totalStoriesPosted(context) {
    return Container(
      height: 125,
      width: 135,
      child: Card(
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: Center(
          child: ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.book,
              size: 22,
              color: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTColor
                  : ColorResourcesDark.mainDARKColor,
            ),
            title: Text(
              'Stories posted',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            subtitle: CustomCounter(
                percentage:
                    double.parse(controller.storiesPosted.length.toString())),
          ),
        ),
      ),
    );
  }

  Widget totalLikedStories(context) {
    return Container(
      height: 125,
      width: 135,
      child: Card(
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: Center(
          child: ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.solidHeart,
              size: 22,
              color: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTColor
                  : ColorResourcesDark.mainDARKColor,
            ),
            title: Text(
              'Total likes',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            subtitle: CustomCounter(
                percentage:
                    double.parse(controller.totallikes.value.toString())),
          ),
        ),
      ),
    );
  }

  Widget recentStories(context) {
    return Obx(() {
      return Container(
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Text(
                    'Recent stories by ${controller.authName.value}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 15),
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: controller.storiesPosted.length < 3
                      ? controller.storiesPosted.length
                      : 3,
                  options: CarouselOptions(
                      height: 170,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (itemIndex, reason) {
                        controller.count.value = itemIndex;
                      }),
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    var recentStories = controller.storiesPosted[itemIndex];
                    var dateTime =
                        DateTime.parse(recentStories.dateadded.toString());
                    var formate1 =
                        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                    if (controller.storiesPosted.isNotEmpty) {
                      return CustomStoryBarWidgetView(
                        profileOnTapped: () =>
                            Get.toNamed(Routes.OTHER_PROFILE),
                        trailingOnTap: () => CustomSnackbar(
                                title: 'Warning',
                                message:
                                    'Read the story before adding it to favorites')
                            .showWarning(),
                        likes: recentStories.likes,
                        authorProfilePic: recentStories.personprofilepic,
                        storyTitle: recentStories.title,
                        storyCategory: recentStories.category,
                        authorName: recentStories.personname,
                        storyDate: formate1,
                        authorId: recentStories.personid,
                        storyId: recentStories.id,
                        listTileOnTap: () =>
                            Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
                          {"authorname": recentStories.personname},
                          {"authorprofilepic": recentStories.personprofilepic},
                          {"authorid": recentStories.personid},
                          {"storytitle": recentStories.title},
                          {"storycategory": recentStories.category},
                          {"storybody": recentStories.body},
                          {"storylikes": recentStories.likes},
                          {"storyid": recentStories.id},
                          {"storydate": formate1.toString()}
                        ]),
                        storyBody: recentStories.body,
                        readmoreOnTap: () =>
                            Get.toNamed(Routes.FULL_SCREEN_STORY, arguments: [
                          {"authorname": recentStories.personname},
                          {"authorprofilepic": recentStories.personprofilepic},
                          {"authorid": recentStories.personid},
                          {"storytitle": recentStories.title},
                          {"storycategory": recentStories.category},
                          {"storybody": recentStories.body},
                          {"storylikes": recentStories.likes},
                          {"storyid": recentStories.id},
                          {"storydate": formate1.toString()}
                        ]),
                      );
                    } else {
                      return Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor:
                                ColorResourcesLight.mainLIGHTAPPBARcolor,
                            color: ColorResourcesLight.mainLIGHTColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      controller.storiesPosted.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorResourcesDark.mainDARKColor
                                    : ColorResourcesLight.mainLIGHTColor)
                                .withOpacity(controller.count.value == entry.key
                                    ? 0.9
                                    : 0.4)),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
            controller.isLoading.value
                ? Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor:
                            ColorResourcesLight.mainLIGHTAPPBARcolor,
                        color: ColorResourcesLight.mainLIGHTColor,
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      );
    });
  }
}
