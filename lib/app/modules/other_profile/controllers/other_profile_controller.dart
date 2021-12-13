import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_diaries/app/data/Models/author_details_model.dart';
import 'package:travel_diaries/app/data/Models/my_stories_model.dart';

class OtherProfileController extends GetxController {
  //TODO: Implement OtherProfileController

  final count = 0.obs;
  final isLoading = false.obs;
  var authorDetails = <AuthorDetailsModel>[].obs;
  var storiesPosted = <MyStoriesModel>[].obs;
  var totallikes = 0.obs;

// ? profile details
  var authId = ''.obs;
  var authName = ''.obs;
  var authFav = ''.obs;
  var authCaption = ''.obs;
  var authProfilePic = ''.obs;
  var authProfileDateCreated = ''.obs;
// ?

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<AuthorDetailsModel>> getAuthorDetails(id, name) async {
    isLoading.value = true;

    var url = 'http://ubermensch.studio/travel_stories/getauthordetails.php';
    var data = {"id": id, "name": name};

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      isLoading.value = false;

      var jsonString = res.body;
      print(jsonString);
      return authorDetailsModelFromJson(jsonString);
    } else {
      isLoading.value = false;

      throw Exception();
    }
  }

  void addAuthorDetails(id, name) async {
    var authordetails = await getAuthorDetails(id, name);
    authId.value = authordetails[0].id;
    authName.value = authordetails[0].name;
    authFav.value = authordetails[0].fav;
    authCaption.value = authordetails[0].caption;
    authProfilePic.value = authordetails[0].profilepicture;
    authProfileDateCreated.value = authordetails[0].datecreated.toString();
    authorDetails.assignAll(authordetails);
  }

  Future<List<MyStoriesModel>> getStoriesPosted(personId, personName) async {
    isLoading.value = true;
    var url = 'http://ubermensch.studio/travel_stories/getmystories.php';
    var data = {"personid": personId, "personname": personName};

    http.Response res = await http.post(Uri.parse(url), body: data);
    print(res.statusCode);
    if (res.statusCode == 200) {
      isLoading.value = false;

      var jsonString = res.body;
      print(jsonString);

      return myStoriesModelFromJson(jsonString);
    } else {
      isLoading.value = false;

      throw Exception();
    }
  }

  void addStoriedPosted(id, name) async {
    var storydetails = await getStoriesPosted(id, name);
    storiesPosted.assignAll(storydetails);
    totalLikes();
  }

  void totalLikes() {
    for (var i = 0; i < storiesPosted.length; i++) {
      totallikes.value += int.parse(storiesPosted[i].likes);
    }
    print("total likes : ${totallikes.value}");
  }
}
