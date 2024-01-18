import 'package:letschat_flutter/consts/consts.dart';

class StoreServices {
  //get user data
  static getUser(String id) {
    return firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: id)
        .get();
  }

  //get all users from our firebase user collection
  static getAllUsers() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }

  static getChats(String chatId) {
    //get all the messages from
    //chats collection -> chat id doc -> message collection
    return firebaseFirestore
        .collection(collectionChats)
        .doc(chatId)
        .collection(collectionMessage)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getMessages() {
    return firebaseFirestore
        .collection(collectionChats)
        .where("users.${currentUser!.uid}", isEqualTo: null)
        .where("created_on", isNotEqualTo: null)
        .snapshots();
  }
}
