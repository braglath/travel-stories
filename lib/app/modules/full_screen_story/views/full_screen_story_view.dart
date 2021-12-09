import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/modules/app_bar/views/app_bar_view.dart';

import '../controllers/full_screen_story_controller.dart';

class FullScreenStoryView extends GetView<FullScreenStoryController> {
  final data = Get.arguments;

  @override
  final controller = Get.find(tag: 'fullscreenstorycontroller');

  @override
  Widget build(BuildContext context) {
    final String authorName = data[0]['authorname'];
    final String authorprofilepic = data[1]['authorprofilepic'];
    final String authorid = data[2]['authorid'];
    final String storytitle = data[3]['storytitle'];
    final String storycategory = data[4]['storycategory'];
    final String storybody = data[5]['storybody'];
    final String storylikes = data[6]['storylikes'];
    final String storyid = data[7]['storyid'];
    final String storydate = data[8]['storydate'];

    controller.count.value = int.parse(storylikes);
    // ? checking user already like or not
    controller.checkLikedStories(
        title: storytitle,
        authorid: authorid,
        likedpersonid: UserDetails().readUserIDfromBox(),
        likedpersonname: UserDetails().readUserNamefromBox());

    return Scaffold(
      appBar: AppBarView(
        title: 'Stories',
      ),
      body: SingleChildScrollView(
        child: FadedScaleAnimation(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTAPPBARcolor
                    : ColorResourcesDark.mainDARKAPPBARcolor,
                boxShadow: [
                  BoxShadow(
                    color: ColorResourcesLight.mainTextHEADINGColor
                        .withOpacity(0.2),
                    offset: const Offset(
                      5.0,
                      2.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                  //BoxShadow
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTAPPBARcolor
                          : ColorResourcesDark.mainDARKAPPBARcolor,
                    ),
                    child: ListTile(
                      // isThreeLine: true,
                      trailing: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300.withOpacity(0.4),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Obx(
                          () {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidHeart,
                                  size: 15,
                                  color: controller.isLiked.isFalse
                                      ? null
                                      : ThemeService().theme == ThemeMode.light
                                          ? ColorResourcesLight.mainLIGHTColor
                                          : ColorResourcesDark.mainDARKColor,
                                ),
                                Text(
                                  controller.count.toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                ThemeService().theme == ThemeMode.light
                                    ? ColorResourcesLight.mainLIGHTColor
                                    : ColorResourcesDark.mainDARKColor,
                            radius: 25,
                            child: CircleAvatar(
                                radius: 22,
                                child: authorprofilepic.isEmpty
                                    ? Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      )
                                    : null,
                                backgroundColor:
                                    ThemeService().theme == ThemeMode.light
                                        ? ColorResourcesLight.mainLIGHTColor
                                        : ColorResourcesDark.mainDARKColor,
                                backgroundImage: NetworkImage(
                                    "http://ubermensch.studio/travel_stories/profileimages/$authorprofilepic")),
                          )
                        ],
                      ),
                      title: Text(
                        storytitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainTextHEADINGColor
                              : ColorResourcesDark.mainDARKTEXTICONcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: IntrinsicHeight(
                          child: Row(
                        children: [
                          Text(
                            storycategory,
                          ),
                          VerticalDivider(
                            thickness: 1,
                          ),
                          Expanded(
                            flex: authorName.length > 10 ? 1 : 0,
                            child: Text(authorName),
                          ),
                          VerticalDivider(
                            thickness: 1,
                          ),
                          Text(
                            storydate,
                          ),
                        ],
                      )),
                      onTap: () => {},
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTAPPBARcolor
                          : ColorResourcesDark.mainDARKAPPBARcolor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 12, right: 12, bottom: 12),
                      child: Text(
                        storybody,
                        style: TextStyle(
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainTextHEADINGColor
                              : ColorResourcesDark.mainDARKTEXTICONcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ThemeService().theme == ThemeMode.light
                          ? ColorResourcesLight.mainLIGHTAPPBARcolor
                          : ColorResourcesDark.mainDARKAPPBARcolor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            color: ThemeService().theme == ThemeMode.light
                                ? ColorResourcesLight.mainLIGHTColor
                                : ColorResourcesDark.mainDARKColor,
                            splashRadius: 12,
                            iconSize: 20,
                            onPressed: () => controller.liked(storylikes,
                                authorid: authorid,
                                authorname: authorName,
                                authorprofilepic: authorprofilepic,
                                likedpersonname:
                                    UserDetails().readUserNamefromBox(),
                                likedpersonid:
                                    UserDetails().readUserIDfromBox(),
                                title: storytitle,
                                category: storycategory,
                                body: storybody,
                                date: storydate),
                            icon: FaIcon(FontAwesomeIcons.heart)),
                        IconButton(
                            padding: EdgeInsets.zero,
                            color: ThemeService().theme == ThemeMode.light
                                ? ColorResourcesLight.mainLIGHTColor
                                : ColorResourcesDark.mainDARKColor,
                            iconSize: 20,
                            splashRadius: 12,
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.shareAlt)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
