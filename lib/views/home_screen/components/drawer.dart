import 'package:get/get.dart';
import 'package:letschat_flutter/consts/consts.dart';
//import 'package:letschat_flutter/controllers/home_controller.dart';
import 'package:letschat_flutter/main.dart';
import 'package:letschat_flutter/views/about_screen/about.dart';
import 'package:letschat_flutter/views/help_page/help.dart';
import 'package:letschat_flutter/views/notification_screen/notification.dart';
import 'package:letschat_flutter/views/views.dart';

import '../../../controllers/home_controller.dart';

Widget drawer() {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: drawerGradient,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                backIcon,
                color: Colors.white,
              ).onTap(() {
                Get.back();
              }),
              title: setting.text.fontFamily(semibold).white.make(),
            ),
            20.heightBox,
            CircleAvatar(
              radius: 70,
              backgroundColor: bgColor,
              child: Image.network(
                HomeController.instance.userImage,
                fit: BoxFit.cover,
              )
                  .scale(scaleValue: 1)
                  .box
                  .roundedFull
                  .clip(Clip.antiAlias)
                  .make(),
            ),
            10.heightBox,
            HomeController.instance.username.text.white
                .fontFamily(semibold)
                .size(16)
                .make(),
            20.heightBox,
            const Divider(
              color: btnColor,
              height: 1,
            ),
            10.heightBox,
            ListView(
              shrinkWrap: true,
              children: List.generate(
                  drawericonsList.length,
                  (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const ProfileScreen(),
                                  transition: Transition.downToUp);

                              break;
                            //default:
                            case 1:
                              Get.to(() => const ComposeScreen(),
                                  transition: Transition.downToUp);
                              break;

                            case 2:
                              Get.to(() => NotificationPage(),
                                  transition: Transition.downToUp);
                              break;
                            case 3:
                              Get.to(() => const AboutPage(),
                                  transition: Transition.downToUp);
                              break;

                            case 4:
                              Get.to(() => const Helppage(),
                                  transition: Transition.downToUp);
                              break;
                          }
                        },
                        leading: Icon(
                          drawericonsList[index],
                          color: Colors.white,
                        ),
                        title: drawerListTitles[index]
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                      )),
            ),
            10.heightBox,
            const Divider(color: btnColor, height: 1),
            10.heightBox,
            ListTile(
              leading: Icon(
                inviteIcon,
                color: Colors.white,
              ),
              title: invite.text.fontFamily(semibold).white.make(),
            ),
            const Spacer(),
            ListTile(
              onTap: () async {
                await auth.signOut();
                Get.offAll(() => const ChatApp());
              },
              leading: const Icon(
                logoutIcon,
                color: Colors.white,
              ),
              title: logout.text.fontFamily(semibold).white.make(),
            )
          ],
        ),
      ),
    ),
  );
}
