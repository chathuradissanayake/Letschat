import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/controllers/profile_controller.dart';
import 'package:letschat_flutter/services/store_services.dart';
import 'package:letschat_flutter/views/profile_screen/components/picker_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init profile controller
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: const Icon(
          backIcon,
          color: ylColor,
        ).onTap(() {
          Get.back();
        }),
        backgroundColor: blColor,
        elevation: 0.0,
        title: Text(
          profile,
          style: GoogleFonts.ubuntu(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: ylColor,
            shadows: [
              const Shadow(
                color: shadowcl, // Shadow color
                offset: Offset(2.0, 2.0), // Shadow offset
                blurRadius: 3.0, // Shadow blur radius
              ),
            ],
          ),
        ),
        //title: profile.text.fontFamily(bold).white.make(),
        //backgroundColor: Colors.transparent,
        //elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () async {
                if (controller.imgpath.isEmpty) {
                  //if image is selected then only update the values
                  controller.updateProfile(context);
                } else {
                  //update both profile image and value
                  //lets wait for our image to be uploaded first then execute the update profile method
                  await controller.uploadImage();
                  controller.updateProfile(context);
                }
              },
              child: "Save".text.white.fontFamily(semibold).make())
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(bgimg2), fit: BoxFit.cover),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),

          //init future builder
          child: FutureBuilder(
            //passing current user id to the function to get the user document
            future: StoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //if data is landed show the widget

              if (snapshot.hasData) {
                //settinf snapshot to variable for each access
                //here doc[0]nbecause it will contain only one document
                var data = snapshot.data!.docs[0];

                //setting values to the text cotrollers
                controller.nameController.text = data["name"];
                controller.phoneController.text = data["phone"];
                controller.aboutController.text = data["about"];

                return Column(
                  children: [
                    10.heightBox,
                    //wrapping our widget if obx

                    Obx(
                      () => CircleAvatar(
                        radius: 80,
                        backgroundColor: btnColor,
                        child: Stack(
                          children: [
                            //when image path is empty
                            controller.imgpath.isEmpty &&
                                    data['image_url'] == ''
                                ? Image.asset(
                                    ic_user,
                                    color: Colors.white,
                                    //when image path is
                                  )
                                : controller.imgpath.isNotEmpty
                                    ? Image.file(File(controller.imgpath.value))
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make()
                                    : Image.network(
                                        data['image_url'],
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make(),
                            Positioned(
                              right: 0,
                              bottom: 20,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 73, 73, 73),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ).onTap(() {
                                  //using getx dialog and passing our widjet
                                  //passing context and our controller  to the widget
                                  Get.dialog(pickerDialog(context, controller));
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    10.heightBox,
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: txtColor,
                      ),
                      title: TextFormField(
                        //setting controller
                        controller: controller.nameController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 121, 135, 240),
                            fontFamily: light),
                        cursorColor: Color.fromARGB(255, 121, 135, 240),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.edit, color: txtColor),
                          label: "Name".text.color(txtColor).make(),
                          isDense: true,
                          labelStyle: const TextStyle(fontFamily: semibold),
                        ),
                      ),
                      subtitle:
                          namesub.text.fontFamily(light).size(5).gray500.make(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.info,
                        color: txtColor,
                      ),
                      title: TextFormField(
                        //setting controller
                        controller: controller.aboutController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 121, 135, 240),
                            fontFamily: light),
                        cursorColor: Color.fromARGB(255, 121, 135, 240),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.edit, color: txtColor),
                          label: "About".text.color(txtColor).make(),
                          isDense: true,
                          labelStyle: const TextStyle(fontFamily: semibold),
                        ),
                      ),
                    ),
                    16.heightBox,
                    ListTile(
                      leading: const Icon(
                        Icons.call,
                        color: txtColor,
                      ),
                      title: TextFormField(
                        //setting controller
                        controller: controller.phoneController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 101, 153, 195),
                        ),
                        readOnly: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          label: "Phone".text.color(txtColor).make(),
                          isDense: true,
                          labelStyle: const TextStyle(fontFamily: semibold),
                        ),
                      ),
                    ),
                    240.heightBox,
                  ],
                );
              } else {
                //if data not landed yet show progress indicator
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
