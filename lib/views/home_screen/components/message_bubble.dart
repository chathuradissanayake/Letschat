import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/views/chat_screen/chat_screen.dart';

Widget messageBubble(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Card(
    color: Colors.transparent,
    child: Container(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          Get.to(
            () => const ChatScreen(),
            transition: Transition.downToUp,
            arguments: [
              currentUser!.uid == doc['toId']
                  ? doc['friend_name']
                  : doc['user_name'],
              currentUser!.uid == doc['toId'] ? doc['fromId'] : doc['toId']
            ],
          );
        },
        leading: CircleAvatar(
          backgroundColor: btnColor,
          radius: 25,
          child: Image.asset(
            ic_user,
            color: Colors.white,
          ),
        ),

        // CircleAvatar(
        //                                 radius: 35,
        //                                 backgroundImage:
        //                                     NetworkImage("${doc['image_url']}"),
        //                               ),
        title: currentUser!.uid == doc['toId']
            ? "${doc['user_name']}".text.fontFamily(semibold).size(14).make()
            : "${doc['friend_name']}".text.size(16).semiBold.make(),
        subtitle: "${doc['last_msg']}".text.maxLines(1).size(14).make(),
        trailing: Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(
                Icons.access_time_filled_rounded,
                size: 16,
                color: Vx.gray200,
              ),
              label: time.text.color(Vx.gray200).size(12).make()),
        ),
      ),
    ),
  );
}
