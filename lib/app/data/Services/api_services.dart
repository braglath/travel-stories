import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Models/fav_stories_model.dart';
import 'package:travel_diaries/app/data/Models/my_stories_model.dart';
import 'package:travel_diaries/app/data/Models/stories_model.dart';
import 'package:travel_diaries/app/data/Models/top_stories_model.dart';
import 'package:travel_diaries/app/data/storage/user_details.dart';
import 'package:travel_diaries/app/views/views/custom_snackbar_view.dart';

class APIservices {
  static var client = http.Client();
  static Future<List<StoriesModel>> getStories(String category) async {
    print(category);
    var url = 'http://ubermensch.studio/travel_stories/getstories.php';
    var data = {
      "category": category,
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonString = res.body;
      print(jsonString);
      return storiesModelFromJson(jsonString);
    } else {
      return [];
    }
  }

  static Future<List<FavStoriesModel>> fetchFavStories() async {
    var url = 'http://ubermensch.studio/travel_stories/fetchfavstories.php';
    var data = {
      "likedpersonid": UserDetails().readUserIDfromBox(),
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonString = res.body;
      print(jsonString);
      return favStoriesModelFromJson(jsonString);
    } else {
      return [];
    }
  }

  static Future<List<MyStoriesModel>> fetchMyStories() async {
    var url = 'http://ubermensch.studio/travel_stories/getmystories.php';
    var data = {
      "personid": UserDetails().readUserIDfromBox(),
      "personname": UserDetails().readUserNamefromBox(),
    };

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonString = res.body;
      print(jsonString);
      return myStoriesModelFromJson(jsonString);
    } else {
      return [];
    }
  }

  static Future<List<TopStoriesModel>> fetchTopStories() async {
    final url = 'http://ubermensch.studio/travel_stories/gettopstories.php';
    var response = await client.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return topStoriesModelFromJson(jsonString);
    } else {
      return <TopStoriesModel>[];
    }
  }
}