import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/controllers/chat_controller.dart';
import 'package:letschat_flutter/services/store_services.dart';
import 'package:letschat_flutter/views/compose_screen/components/chat_bubble.dart';

export './chat_screen.dart';

class ChatScreen extends StatelessWidget {
  //final String? user;
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: const Icon(
          backIcon,
          color: Colors.white,
        ).onTap(() {
          Get.back();
        }),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: const [
          Icon(Icons.more_vert_rounded, color: Colors.white),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: RichText(
                  //textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${controller.friendname}\n",
                        style: const TextStyle(
                            fontFamily: semibold,
                            fontSize: 20,
                            color: bgColor)),
                    const TextSpan(
                        text: "Last Seen",
                        style: TextStyle(
                            fontFamily: light, fontSize: 12, color: Vx.gray400))
                  ]),
                )),
                const CircleAvatar(
                  backgroundColor: bgColor,
                  child: Icon(
                    Icons.video_call_rounded,
                    color: Colors.white,
                  ),
                ),
                10.widthBox,
                const CircleAvatar(
                  backgroundColor: bgColor,
                  child: Icon(
                    Icons.call_rounded,
                    color: Colors.white,
                  ),
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.video_call_rounded,
                //       color: Vx.gray700,
                //     ))
              ],
            ),
          ),
          20.heightBox,

          //chat body
          Obx(
            () => Expanded(
              child: controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(bgColor)),
                    )
                  : StreamBuilder(
                      stream: StoreServices.getChats(controller.chatId),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var doc = snapshot.data!.docs[index];
                              return chatBubble(index, doc);
                            }).toList(),
                          );
                        }
                      }),
            ),
          ),
          10.heightBox,
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: bgColor,
                    //   borderRadius: BorderRadius.circular(16),
                    // ),

                    decoration: BoxDecoration(
                        border: Border.all(color: txtColor, width: 1)),
                    child: TextFormField(
                      //send message controller
                      controller: controller.messageController,
                      maxLines: 1,
                      style:
                          const TextStyle(color: txtColor, fontFamily: light),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.emoji_emotions_rounded,
                            color: txtColor,
                          ),
                          suffixIcon: Icon(
                            Icons.attachment_outlined,
                            color: txtColor,
                          ),
                          border: InputBorder.none,
                          hintText: "Type your message here..",
                          hintStyle: TextStyle(
                            fontFamily: light,
                            fontSize: 14,
                            //color: Colors.white
                          )),
                    ),
                  ),
                ),
                10.widthBox,
                GestureDetector(
                  onTap: () {
                    //ontap of this to send message
                    controller.sendmessage(controller.messageController.text);
                  },
                  child: const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
