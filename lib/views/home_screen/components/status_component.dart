import 'package:letschat_flutter/consts/consts.dart';

Widget statusComponent() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: btnColor,
            child: Image.asset(
              ic_user,
              color: Colors.white,
            ),
          ),
          title: "My status".text.fontFamily(semibold).color(txtColor).make(),
          subtitle: "tap to add status updates".text.gray400.make(),
        ),
        20.heightBox,
        recentupdates.text.fontFamily(semibold).gray500.make(),
        20.heightBox,
        ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: txtColor, width: 1)),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Vx.randomPrimaryColor,
                        child: Image.asset(ic_user),
                      ),
                    ),
                    title: "User name"
                        .text
                        .fontFamily(semibold)
                        .color(txtColor)
                        .make(),
                    subtitle: "Today, 8.47PM".text.gray500.make()),
              );
            })
      ],
    ),
  );
}
