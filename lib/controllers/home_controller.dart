import 'package:get/get.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  static HomeController instance = Get.find();

  String username = '';
  String userImage = '';

  getUsersDetails() async {
    await firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) async {
      username = value.docs[0]['name'];
      userImage = value.docs[0]['image_url'];
      prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          'user_details', [value.docs[0]['name'], value.docs[0]['image_url']]);
    });
  }

  @override
  void onInit() {
    getUsersDetails();
    super.onInit();
  }
}
