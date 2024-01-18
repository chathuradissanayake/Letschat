import 'package:get/get.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:letschat_flutter/controllers/home_controller.dart';
import 'package:letschat_flutter/views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    //init home controller
    var controller = Get.put(HomeController());

    return Container(
      child: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            key: scaffoldKey,
            drawer: drawer(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: txtColor,
              onPressed: () {
                //goto compose screen
                Get.to(() => const ComposeScreen(),
                    transition: Transition.downToUp);
              },
              child: const Icon(
                Icons.message,
                color: Colors.white,
              ),
            ),
            backgroundColor: bgColor,
            body: Container(
              child: Column(
                children: [
                  appbar(scaffoldKey),
                  tabbar(),
                  Expanded(
                      child: Row(
                    children: [
                      tabbarView(),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
