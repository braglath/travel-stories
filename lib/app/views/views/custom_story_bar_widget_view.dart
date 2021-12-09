import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';
import 'package:travel_diaries/app/routes/app_pages.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class CustomStoryBarWidgetView extends GetView {
  Function()? trailingOnTap;
  String likes;
  String authorProfilePic;
  String storyTitle;
  String storyCategory;
  String authorName;
  String storyDate;
  String authorId;
  String storyId;
  Function()? listTileOnTap;
  Function()? listTileOnLongPressed;
  String storyBody;
  Function()? readmoreOnTap;
  CustomStoryBarWidgetView(
      {required this.likes,
      required this.trailingOnTap,
      required this.authorProfilePic,
      required this.storyTitle,
      required this.storyCategory,
      required this.authorName,
      required this.storyDate,
      required this.authorId,
      required this.storyId,
      required this.listTileOnTap,
      required this.listTileOnLongPressed,
      required this.storyBody,
      required this.readmoreOnTap});
  @override
  Widget build(BuildContext context) {
    return FadedScaleAnimation(
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
                color:
                    ColorResourcesLight.mainTextHEADINGColor.withOpacity(0.2),
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
            children: [
              ListTile(
                  // isThreeLine: true,
                  trailing: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.4),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: InkWell(
                      splashColor: Colors.red,
                      onTap: trailingOnTap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: ModalRoute.of(context)!
                                    .settings
                                    .name!
                                    .contains('/fave-stories')
                                ? ThemeService().theme == ThemeMode.light
                                    ? ColorResourcesLight.mainLIGHTColor
                                    : ColorResourcesDark.mainDARKColor
                                : ColorResourcesLight.mainTextBODYColor
                                    .withOpacity(0.5),
                            size: 15,
                          ),
                          Text(
                            likes.isEmpty ? '0' : likes,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: ThemeService().theme == ThemeMode.light
                            ? ColorResourcesLight.mainLIGHTColor
                            : ColorResourcesDark.mainDARKColor,
                        radius: 25,
                        child: CircleAvatar(
                          radius: 22,
                          child: authorProfilePic.isNotEmpty
                              ? null
                              : Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                          backgroundColor: authorProfilePic.isNotEmpty
                              ? null
                              : ThemeService().theme == ThemeMode.light
                                  ? ColorResourcesLight.mainLIGHTColor
                                  : ColorResourcesDark.mainDARKColor,
                          backgroundImage: authorProfilePic.isNotEmpty
                              ? NetworkImage(
                                  "http://ubermensch.studio/travel_stories/profileimages/$authorProfilePic")
                              : null,
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    storyTitle,
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
                        storyCategory,
                      ),
                      VerticalDivider(
                        thickness: 1,
                      ),
                      Expanded(
                        flex: authorName.length > 8 ? 1 : 0,
                        child: Text(authorName),
                      ),
                      VerticalDivider(
                        thickness: 1,
                      ),
                      Text(storyDate.toString()),
                    ],
                  )),
                  onLongPress: listTileOnLongPressed,
                  onTap: listTileOnTap),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        storyBody,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainTextHEADINGColor
                              : ColorResourcesDark.mainDARKTEXTICONcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: readmoreOnTap,
                      child: Text(
                        'Read more',
                        style: TextStyle(
                          color: ThemeService().theme == ThemeMode.light
                              ? ColorResourcesLight.mainLIGHTColor
                              : ColorResourcesDark.mainDARKColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
