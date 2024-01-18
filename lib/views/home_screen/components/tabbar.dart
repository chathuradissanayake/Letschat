import 'package:letschat_flutter/consts/consts.dart';

Widget tabbar() {
  return Container(
    decoration: BoxDecoration(
      gradient: myGradient,
    ),
    child: const RotatedBox(
      quarterTurns: 0,
      child: TabBar(
        labelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelColor: Vx.gray400,
        indicator: BoxDecoration(color: Colors.transparent),
        //dividerColor: Colors.white,
        tabs: [
          Tab(
            child: Text(
              'Chats',
              style: TextStyle(
                fontSize: 16, // Set your desired font size
                fontWeight: FontWeight.bold, // Set your desired font weight
                // You can customize other text properties here
              ),
            ),
          ),
          Tab(
            child: Text(
              'Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Call',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
