import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/controllers/home_controller.dart';

class ChatController extends GetxController {
  dynamic chatId;

  var chats = firebaseFirestore.collection(collectionChats);
  var userId = currentUser!.uid;
  var friendId = Get.arguments[1];
  var username =
      HomeController.instance.prefs.getStringList('user_details')![0];
  var friendname = Get.arguments[0];
  var messageController = TextEditingController();

  var isloading = false.obs;

  //creating the chatroom
  getChatId() async {
    await chats
        .where('users', isEqualTo: {friendId: null, userId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            //if chatroom is already created then assign the id to our chatid variable
            chatId = snapshot.docs.single.id;
          } else {
            //if no room created then create one
            chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': friendname,
              'user_name': username,
              'toId': '',
              'fromId': '',
              'created_on': null,
              'last_msg': '',
            }).then((value) {
              //assign the doc id to our chatid variable
              {
                chatId = value.id;
              }
            });
          }
        });
    isloading(false);
  }

  //send message method
  sendmessage(String msg) {
    if (msg.trim().isNotEmptyAndNotNull) {
      //if message not empty or null
      //first update the chat id doc and then save the message to database

      chats.doc(chatId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': userId,
      });
      //now save the message in database
      chats.doc(chatId).collection(collectionMessage).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        //uid use to identify who send the message
        'uid': userId,
      }).then(
        (value) {
          messageController.clear();
        },
      );
    }
  }

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
}
