import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';
import 'package:travel_diaries/app/modules/animations/faded_scale_animation.dart';

class CustomStoryBarWidgetView extends GetView {
  final Function()? trailingOnTap;
  final String likes;
  final String authorProfilePic;
  final String storyTitle;
  final String storyCategory;
  final String authorName;
  final String storyDate;
  final String authorId;
  final String storyId;
  final Function()? listTileOnTap;
  final String storyBody;
  final Function()? readmoreOnTap;
  final Function()? profileOnTapped;
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
      required this.storyBody,
      required this.readmoreOnTap,
      required this.profileOnTapped});
  @override
  Widget build(BuildContext context) {
    print(authorProfilePic);
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
                            style: context.theme.textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  leading: InkWell(
                    onTap: profileOnTapped,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              ThemeService().theme == ThemeMode.light
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
                                ? NetworkImage(authorProfilePic
                                        .contains('https')
                                    ? authorProfilePic
                                    : "http://ubermensch.studio/travel_stories/profileimages/${authorProfilePic}")
                                : null,
                          ),
                        )
                      ],
                    ),
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        storyCategory,
                        style: context.theme.textTheme.caption
                            ?.copyWith(fontSize: 12),
                      ),
                      Container(
                        height: 12,
                        child: VerticalDivider(
                          thickness: 1,
                        ),
                      ),
                      Text(
                        authorName.length > 12
                            ? authorName.replaceFirst(" ", "\n")
                            : authorName,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.caption
                            ?.copyWith(fontSize: 12),
                      ),
                      Container(
                        height: 12,
                        child: VerticalDivider(
                          thickness: 1,
                        ),
                      ),
                      Text(
                        storyDate.toString().trim(),
                        style: context.theme.textTheme.caption
                            ?.copyWith(fontSize: 12),
                      ),
                    ],
                  )),
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
