import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/services/store_services.dart';
import 'package:letschat_flutter/views/home_screen/components/message_bubble.dart';

Widget chatsComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: StreamBuilder(
      stream: StoreServices.getMessages(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          //if data not received yet
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(bgColor),
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          //if no message found
          return Center(
            child: "Start a conversation.."
                .text
                .fontFamily(semibold)
                .color(txtColor)
                .make(),
          );
        } else {
          return ListView(
            children: snapshot.data!.docs.mapIndexed((currentValue, index) {
              var doc = snapshot.data!.docs[index];
              return messageBubble(doc);
            }).toList(),
          );
        }
      },
    ),
  );
}
