import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:lottie/lottie.dart';

class Helppage extends StatelessWidget {
  const Helppage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Help',
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
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bgimg2), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                "https://lottie.host/fca0bdd8-c06f-47fb-aa7f-5ef26914620c/t0EqiAiEbX.json"),
            Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'If you have any questions or issues, feel free to contact us.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: support@example.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: +94773084850',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to handle the help button click
              },
              child: Text('Request Help'),
            ),
          ],
        ),
      ),
    );
  }
}
