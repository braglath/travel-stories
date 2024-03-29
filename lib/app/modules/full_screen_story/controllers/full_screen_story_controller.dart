import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:travel_diaries/app/data/Models/comments_model.dart';
import 'package:travel_diaries/app/data/Services/api_services.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class FullScreenStoryController extends GetxController {
  //TODO: Implement FullScreenStoryController

  final count = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLarge = false.obs;
  final height = 0.obs;
  RxString comment = ''.obs;
  RxString storyID = ''.obs;
  RxString storyTitle = ''.obs;
  final focusNode = FocusNode().obs;

  var comments = <CommentsModel>[].obs;

  GlobalKey<FormState> commentkey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void onReady() {
    super.onReady();
    getComments();
  }

  @override
  void onClose() {}

  void takeScreenshot() async {
    isLoading.value = true;
    final image = await screenshotController.capture();
    if (image == null) {
      isLoading.value = false;
      return;
    } else {
      print('screenshot taken');
      await saveAndShare(image);
    }
  }

  Future<void> saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/travel_stories.png');
    image.writeAsBytesSync(bytes);
    final text =
        '_Travel Stories - Share your travel incidents to the world_\n\n*Download the app now from google play store*';
    await Share.shareFiles([image.path], text: text);
    isLoading.value = false;
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'screenshot_$time';
    print('screenshot image saved');
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    print('screenshot file path - ${result['filePath']}');
    return result['filePath'];
  }

  void animateContainer() {
    if (isLarge.value == false) {
      height.value = 125;
      isLarge.value = true;
    } else {
      height.value = 0;
      isLarge.value = false;
    }
  }

  String? validateComment(String value) {
    if (value.isEmpty) {
      return 'cannot be empty';
    }
    return null;
  }

  void commentValidator() {
    final isValid = commentkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      commentkey.currentState?.save();
      postComments();
    }
  }

  void postComments() async {
    var url = 'http://ubermensch.studio/travel_stories/postcomments.php';
    var data = {
      'commenterid': UserDetails().readUserIDfromBox(),
      'commentername': UserDetails().readUserNamefromBox(),
      'commenterprofilepic': UserDetails().readUserProfilePicfromBox(),
      'comment': comment.toString(),
      'storyid': storyID.toString(),
      'storytitle': storyTitle.toString(),
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains('already commented')) {
      print('already commented');

      height.value = 0;
      isLarge.value = false;
      commentController.clear();
      focusNode.value.previousFocus();
      CustomSnackbar(
              title: 'Warning',
              message: 'You have already commented for this story')
          .showWarning();
    } else {
      if (details.toString().contains('true')) {
        print('comment posted');
        getComments();
        await APIservices.getComments(
                storyid: storyID.toString(), storytitle: storyTitle.toString())
            .then((value) => comments.assignAll(value));
        print(comments);
        height.value = 0;
        isLarge.value = false;
        commentController.clear();
        focusNode.value.previousFocus();
        // todo change stories table in sql
        CustomSnackbar(
                title: 'Posted',
                message: 'Your comment has been successfully posted')
            .showSuccess();
      } else if (details.toString().contains('false')) {
        print('check connection');
        CustomSnackbar(
                title: 'Warning', message: 'Check your internet connection')
            .showWarning();
      }
    }
  }

  void getComments() async {
    await APIservices.getComments(
            storyid: storyID.toString(), storytitle: storyTitle.toString())
        .then((value) => comments.assignAll(value));
  }

  void liked(
    String likes, {
    required String authorid,
    required String authorname,
    required String authorprofilepic,
    required String likedpersonname,
    required String likedpersonid,
    required String title,
    required String category,
    required String body,
    required String date,
  }) {
    print(authorprofilepic);
    isLiked.value = !isLiked.value;
    print('is liked - $isLiked');
    if (isLiked.isTrue) {
      if (authorid == likedpersonid) {
        CustomSnackbar(
                title: 'Warning', message: 'You cannot like your own story')
            .showWarning();
        isLiked.value = !isLiked.value;
      } else {
        count.value = int.parse(likes) + 1;
        saveStory(
            authorid: authorid,
            authorname: authorname,
            authorprofilepic: authorprofilepic,
            likedpersonname: likedpersonname,
            likedpersonid: likedpersonid,
            title: title,
            category: category,
            body: body,
            date: date);
      }
    } else {
      count.value = count.value - 1;
      removeStory(
          likes: likes,
          title: title,
          authorid: authorid,
          likedpersonid: likedpersonid,
          likedpersonname: likedpersonname,
          authorName: authorname);
    }
  }

  void saveStory({
    required String authorid,
    required String authorname,
    required String authorprofilepic,
    required String likedpersonname,
    required String likedpersonid,
    required String title,
    required String category,
    required String body,
    required String date,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/addfavstories.php';
    // var uri = Uri.parse(url);
    var data = {
      'authorid': authorid,
      'authorname': authorname,
      'authorprofilepic': authorprofilepic,
      'likedpersonname': likedpersonname,
      'likedpersonid': likedpersonid,
      'title': title,
      'category': category,
      'body': body,
      'likes': count.value.toString(),
      'date': date
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains('error')) {
      print('already liked');

      count.value = count.value - 1;
      isLiked.value = false;
      CustomSnackbar(
              title: 'Warning',
              message: 'This story is already in your favorites list')
          .showWarning();
    } else {
      if (details.toString().contains('true')) {
        print('saved to fav');
        // todo change stories table in sql
        updateStoriesAfterLikes(
            authorID: authorid,
            authorName: authorname,
            title: title,
            likes: count.value.toString());
        CustomSnackbar(
                title: 'Saved',
                message:
                    'This story has been successfully saved to your favorites list')
            .showSuccess();
      } else if (details.toString().contains('false')) {
        print('check connection');
        count.value = count.value - 1;
        isLiked.value = false;
        CustomSnackbar(
                title: 'Warning', message: 'Check your internet connection')
            .showWarning();
      }
    }
  }

  void removeStory(
      {required String likes,
      required String title,
      required String authorid,
      required String likedpersonid,
      required String likedpersonname,
      required String authorName}) async {
    var url = 'http://ubermensch.studio/travel_stories/removefavstories.php';
    // var uri = Uri.parse(url);
    var data = {
      'title': title,
      'authorid': authorid,
      'likedpersonid': likedpersonid,
      'likedpersonname': likedpersonname
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains('Story deleted successfully')) {
      // todo change stories table in sql
      updateStoriesAfterLikes(
          authorID: authorid,
          authorName: authorName,
          title: title,
          likes: count.value.toString());
      print('success');
      isLiked.value = false;
      CustomSnackbar(
              title: 'Success',
              message:
                  'Successfully removed the story from your favorites list')
          .showSuccess();
    } else {
      print('error');
      CustomSnackbar(
              title: 'Warning',
              message: 'Error removing story from your favorites list')
          .showWarning();
    }
  }

// ? cheking on build part on view page
  void checkLikedStories({
    required String title,
    required String authorid,
    required String likedpersonid,
    required String likedpersonname,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/checklikedstories.php';
    var data = {
      'title': title,
      'authorid': authorid,
      'likedpersonid': likedpersonid,
      'likedpersonname': likedpersonname
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));
    var details = json.decode(json.encode(res.body));

    if (details.toString().contains('true')) {
      print('already liked');
      isLiked.value = true;
    } else {
      print('not liked before');
      isLiked.value = false;
    }
  }

  // ? updating stories after likes or dislikes
  void updateStoriesAfterLikes({
    required String authorID,
    required String authorName,
    required String title,
    required String likes,
  }) async {
    var url = 'http://ubermensch.studio/travel_stories/updatestorieslikes.php';
    var data = {
      'likes': likes,
      'personid': authorID,
      'personname': authorName,
      'title': title
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(jsonEncode(data));

    if (res.statusCode == 200) {
      print('stories updated');
    } else {
      print('error updating stories');
    }
  }
}
