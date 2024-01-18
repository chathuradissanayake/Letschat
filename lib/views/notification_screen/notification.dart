import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/consts.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications = List.generate(
    10,
    (index) => NotificationItem(
      title: 'New Message',
      content: 'You have a new message from ${Faker().person.name()}',
      timestamp: '2 hours ago',
      userPhoto: Faker().image.image(),
      username: Faker().internet.userName(),
      mobileNumber: Faker().phoneNumber.us(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          backIcon,
          color: bgColor,
        ).onTap(() {
          Get.back();
        }),
        backgroundColor: blColor,
        elevation: 0.0,
        title: Text(
          'Notifications',
          style: GoogleFonts.ubuntu(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: bgColor,
            shadows: [
              // const Shadow(
              //   color: shadowcl, // Shadow color
              //   offset: Offset(2.0, 2.0), // Shadow offset
              //   blurRadius: 3.0, // Shadow blur radius
              // ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgimg2),
            fit: BoxFit.cover,
          ),
          // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          // color: Color.fromARGB(255, 47, 77, 109),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: notifications,
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String timestamp;
  final String userPhoto;
  final String username;
  final String mobileNumber;

  NotificationItem({
    required this.title,
    required this.content,
    required this.timestamp,
    required this.userPhoto,
    required this.username,
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userPhoto),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content),
            SizedBox(height: 4.0),
            Text(
              '$username - $mobileNumber',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: Text(timestamp),
        onTap: () {
          // Add functionality to handle the tap on the notification
        },
      ),
    );
  }
}
