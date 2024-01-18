import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:lottie/lottie.dart';

// ... Other imports ...

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.yellow, // Assuming ylColor is a color variable
        ).onTap(() {
          Get.back();
        }),
        backgroundColor: Colors.blue, // Assuming blColor is a color variable
        elevation: 0.0,
        title: Text(
          'About us',
          style: GoogleFonts.ubuntu(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.yellow, // Assuming ylColor is a color variable
            shadows: [
              const Shadow(
                color: shadowcl, // Assuming shadowcl is a color variable
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
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
          children: [
            Lottie.network(
              "https://lottie.host/01825303-5631-46ca-b2ed-01ef639f56a1/L36rWuNnwq.json",
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to LetsChat !\n'
              'Where meaningful connections come to life through seamless communication.'
              'Our chat app is designed with you in mind, prioritizing simplicity, security, and a delightful user experience.',
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
              'Email: contact@example.com',
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                // Call the method to open the dialer when phone number is tapped
                _callNumber(
                    '+94773084850'); // Replace with your actual phone number
              },
              child: Text(
                'Phone: 0773084850',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue, // Change the color as needed
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
