import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/firebase_options.dart';
import 'package:letschat_flutter/views/home_screen/home.dart';
import 'package:letschat_flutter/views/signin_screen/signin_screen.dart';
import 'package:lottie/lottie.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var isUser = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        setState(() {
          isUser = false;
        });
      } else {
        setState(() {
          isUser = true;
        });
      }
      print("User value is $isUser");
    });
  }

  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "lato"),
      debugShowCheckedModeBanner: false,
      home: isUser ? const HomeScreen() : const ChatApp(),
      title: appname,
    );
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bgimage), fit: BoxFit.cover),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                            "https://lottie.host/0a8e672d-1f56-4830-830f-5df55f9dc856/0URjVDgB7o.json",
                            width: 220),

                        // Image.asset(
                        //   logo,
                        //   width: 220,
                        //   color: ylColor,
                        // ),
                        appname.text
                            .textStyle(
                              GoogleFonts.play(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                                shadows: [
                                  const Shadow(
                                    color: shadowcl, // Shadow color
                                    offset: Offset(2.0, 2.0), // Shadow offset
                                    blurRadius: 3.0, // Shadow blur radius
                                  ),
                                ],
                              ),
                            )
                            .color(ylColor)
                            .make()
                      ]),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.66,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(bgimage2), fit: BoxFit.cover))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.66,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Column(children: [
                  // Text(
                  //   slogan,
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     letterSpacing: 1,
                  //     wordSpacing: 2,
                  //   ),
                  // ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      slogan,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poiretOne(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Material(
                    //color: blColor,
                    //borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blColor, // Background color
                        onPrimary: Colors.white,
                        minimumSize: Size(200.0, 50.0),

                        // Text color
                      ),
                      onPressed: () {
                        Get.to(() => const VerificationScreen(),
                            transition: Transition.downToUp);
                      },
                      child: Text(
                        'Start Messaging',
                        style: GoogleFonts.play(fontSize: 15),
                      ),
                    ),
                  ),
                  5.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      own,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: 8,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: Container(
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           children: [
  //             Expanded(
  //                 flex: 4,
  //                 child: Container(
  //                   //color: Colors.white,
  // child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Image.asset(
  //         logo,
  //         width: 170,
  //       ),
  //       appname.text
  //           .textStyle(
  //             GoogleFonts.play(
  //                 fontWeight: FontWeight.w500, fontSize: 30),
  //           )
  //           .make()
  //     ]),
  //                 )),
  //             Expanded(
  //               flex: 7,
  //               child: Container(
  //                 //color: Colors.blue,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment
  //                       .start, // Align children to the start (left)
  //                   children: [
  //                     Wrap(
  //                         spacing: 10,
  //                         children:
  //                             List.generate(listOfFeatures.length, (index) {
  //                           return Chip(
  //                             backgroundColor: Colors.transparent,
  //                             labelPadding: const EdgeInsets.symmetric(
  //                                 horizontal: 18, vertical: 4),
  //                             side: const BorderSide(color: Vx.gray300),
  //                             label: "${listOfFeatures[index]}".text.make(),
  //                           );
  //                         })),
  //                     140.heightBox,
  //                     const Text(
  //                       "SAY 'helloo'  to \nWORLD!",
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w200,
  //                         fontSize: 30,
  //                       ),
  //                       textAlign: TextAlign.left,
  //                     ),
  //                     //slogan.text.size(20).fontFamily(bold).letterSpacing(2).make(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.black, // Background color
  //                   onPrimary: Colors.white,
  //                   minimumSize: Size(150.0, 10.0),
  //                   // Text color
  //                 ),
  //                 onPressed: () {
  //                   Get.to(() => const VerificationScreen(),
  //                       transition: Transition.downToUp);
  //                 },
  //                 child: Text('Start Messaging'),
  //               ),
  //             ),
  //             40.heightBox,
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

