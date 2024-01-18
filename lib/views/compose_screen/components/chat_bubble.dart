import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import 'package:letschat_flutter/consts/consts.dart';

Widget chatBubble(index, DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h.mma").format(t);

  return Directionality(
    textDirection:
        doc['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(children: [
        CircleAvatar(
          backgroundColor: doc['uid'] == currentUser!.uid ? txtColor : btnColor,
          child: Image.asset(
            ic_user,
            color: Colors.white,
          ),
        ),
        20.widthBox,
        Expanded(
            child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: doc['uid'] == currentUser!.uid ? txtColor : btnColor,
                borderRadius: BorderRadius.circular(12)),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: "${doc['msg']}".text.fontFamily(semibold).white.make(),
            ),
          ),
        )),
        10.widthBox,
        Directionality(
            textDirection: TextDirection.ltr,
            child: time.text.fontFamily(light).size(12).gray400.make()),
      ]),
    ),
  );
}
