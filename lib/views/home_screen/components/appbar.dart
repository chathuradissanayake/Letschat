import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/controllers/home_controller.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    padding: const EdgeInsets.only(right: 12, left: 5),
    decoration: BoxDecoration(gradient: tabbargradient),
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  //topLeft: Radius.circular(100),
                  //bottomRight: Radius.circular(100),
                )),
            height: 80,
            width: 60,
            child: const Icon(
              settingsIcon,
              color: Colors.white,
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     key.currentState!.openDrawer();
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: Container(
        //       child: const Icon(
        //         settingsIcon,
        //         color: bgColor,
        //       ),
        //     ),
        //   ),
        // ),

        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "$appname\n",
                  style: GoogleFonts.play(fontSize: 30, color: Colors.white)
                  //TextStyle(fontFamily: bold, fontSize: 22, color: Colors.black),
                  ),
              TextSpan(
                  text: "SAY 'helloo' to WORLD!",
                  style:
                      GoogleFonts.quicksand(fontSize: 12, color: Colors.white)
                  //style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
            ])),
        CircleAvatar(
          radius: 30,
          child: Image.network(HomeController.instance.userImage)
              .box
              .roundedFull
              .clip(Clip.antiAlias)
              .make(),
        ),
      ],
    ),
  );
}
