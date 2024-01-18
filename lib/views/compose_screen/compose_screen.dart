import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/services/store_services.dart';
import 'package:letschat_flutter/views/chat_screen/chat_screen.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: const Icon(
          backIcon,
          color: Colors.white,
        ).onTap(() {
          Get.back();
        }),
        title: "New Message".text.fontFamily(semibold).size(16).white.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Color.fromARGB(255, 47, 77, 109)),

        //we are using stream builder here for realtime changes
        child: StreamBuilder(
            //set stream function
            stream: StoreServices.getAllUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //fix the transition error in mili seconds
              if (!snapshot.hasData) {
                //if data is not loaded yet
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(bgColor)),
                );
              } else {
                //when data is loaded
                return GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 200),
                  //converting our snapshot into a map for easy access to all the docs
                  children:
                      snapshot.data!.docs.mapIndexed((currentValue, index) {
                    var doc = snapshot.data!.docs[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 104, 154, 195),
                            border: Border.all(color: bgColor.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            NetworkImage("${doc['image_url']}"),
                                      ),
                                      const SizedBox(
                                          height:
                                              8), // Add some space between the avatar and the name
                                      "${doc['name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                    ],
                                  ),
                                ],
                              ),
                              10.heightBox,
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      //padding: const EdgeInsets.all(5),
                                      primary: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Get.to(() => ChatScreen(),
                                          transition: Transition.downToUp,
                                          arguments: [
                                            doc['name'],
                                            doc['id'],
                                          ]);
                                    },
                                    icon: const Icon(
                                      Icons.message,
                                      color: Colors.white,
                                    ),
                                    label: "Message"
                                        .text
                                        .white
                                        .fontFamily(semibold)
                                        .size(12)
                                        .make()),
                              )
                            ],
                          )),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
