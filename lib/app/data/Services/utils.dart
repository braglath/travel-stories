import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:travel_diaries/app/data/storage/user_details.dart';

class Utils {
  static Future<String> downloadFile(
      String profileImageLink, String fileName) async {
    String url1 = '';
    if (profileImageLink.contains('https')) {
      url1 = profileImageLink;
    } else {
      url1 =
          'http://ubermensch.studio/travel_stories/profileimages/$profileImageLink';
    }
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    print('user profile image - ${UserDetails().readUserProfilePicfromBox()}');
    print('user profile image url1 - $url1');
    final url = url1;
    print('user profile - $url');
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);
    print('user profile file response - ${response.body}');
    print('user profile file path - $filePath');
    return filePath;
  }
}
