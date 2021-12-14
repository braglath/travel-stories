import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';

class CommentesCardView {
  Widget showCustomComments(BuildContext context, commentaterName, comment,
      commentaterProfilePic, isLiked, dateTime) {
    var datetime = DateTime.parse(dateTime.toString());
    var formatedDate = "${datetime.day}-${datetime.month}-${datetime.year}";
    var liked = int.parse(isLiked);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: ThemeService().theme == ThemeMode.light
            ? ColorResourcesLight.mainLIGHTAPPBARcolor
            : ColorResourcesDark.mainDARKAPPBARcolor,
        child: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
                radius: 25,
                child: CircleAvatar(
                    radius: 22,
                    child: commentaterProfilePic?.isEmpty == true
                        ? Icon(
                            Icons.person,
                            color: Colors.white,
                          )
                        : null,
                    backgroundColor: ThemeService().theme == ThemeMode.light
                        ? ColorResourcesLight.mainLIGHTColor
                        : ColorResourcesDark.mainDARKColor,
                    backgroundImage: NetworkImage(
                        "http://ubermensch.studio/travel_stories/profileimages/$commentaterProfilePic")),
              )
            ],
          ),
          title: RichText(
            text: TextSpan(
              text: '$commentaterName |',
              style: context.theme.textTheme.caption?.copyWith(fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: ' $formatedDate',
                  style:
                      context.theme.textTheme.caption?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          subtitle: Text(
            comment.toString(),
            style: context.theme.textTheme.headline4,
          ),
          trailing: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              FaIcon(
                liked == 0
                    ? FontAwesomeIcons.heart
                    : FontAwesomeIcons.solidHeart,
                color: ThemeService().theme == ThemeMode.light
                    ? ColorResourcesLight.mainLIGHTColor
                    : ColorResourcesDark.mainDARKColor,
                size: liked == 0 ? 20 : 35,
              ),
              liked == 0
                  ? SizedBox.shrink()
                  : likedProfilePic(commentaterProfilePic),
            ],
          ),
        ),
      ),
    );
  }

  Widget likedProfilePic(String commentaterProfilePic) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTColor
              : ColorResourcesDark.mainDARKColor,
          radius: 10,
          child: CircleAvatar(
              radius: 8,
              child: commentaterProfilePic.isEmpty == true
                  ? Icon(
                      Icons.person,
                      color: Colors.white,
                    )
                  : null,
              backgroundColor: ThemeService().theme == ThemeMode.light
                  ? ColorResourcesLight.mainLIGHTColor
                  : ColorResourcesDark.mainDARKColor,
              backgroundImage: NetworkImage(
                  "http://ubermensch.studio/travel_stories/profileimages/$commentaterProfilePic")),
        )
      ],
    );
  }
}
