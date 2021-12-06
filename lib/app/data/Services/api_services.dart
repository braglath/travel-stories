import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Models/stories_model.dart';

class APIservices {
  static Future<List<StoriesModel>> getStories() async {
    var url = 'http://ubermensch.studio/travel_stories/getstories.php';
    var data = {
      "category": "All",
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
}
