import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letschat_flutter/consts/colors.dart';
import 'package:letschat_flutter/consts/images.dart';
import 'package:letschat_flutter/consts/strings.dart';
import 'package:letschat_flutter/consts/utils.dart';
import 'package:letschat_flutter/controllers/auth_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
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
            "Let's  Connect  !",
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
          centerTitle:
              true, //The getter 'text' is nit defined for the type "String",
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(bgimg2), fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Lottie.network(
                    "https://lottie.host/54f531d8-ca28-41eb-a767-ee10b8993238/dOKuAwNEfp.json",
                    height: 250), // Image.asset(
                //   plane,
                //   width: 220,
                // ),
                Container(
                  child: Form(
                    key: controller.formKey,
                    child: Column(children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Please enter your user name";
                          }
                          return null;
                        },
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Vx.gray400)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Vx.gray400)),
                          prefixIcon: Icon(Icons.verified_user_outlined),
                          alignLabelWithHint: true,
                          labelText: "User name",
                          //prefixText: "+94",
                          hintText: "Alex",
                          labelStyle: const TextStyle(
                              color: Vx.gray600, fontWeight: FontWeight.w200),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
                          prefixStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                          // Change the font weight here
                        ),
                      ),
                      10.heightBox,

                      //phone number
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 9) {
                            return "Please enter your Phone Number";
                          }
                          return null;
                        },
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Vx.gray400)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Vx.gray400)),
                          prefixIcon: const Icon(Icons.phone_android_rounded),
                          alignLabelWithHint: true,
                          labelText: "Phone number",
                          prefixText: "+94 ",
                          hintText: " 777 123 456",
                          labelStyle: const TextStyle(
                              color: Vx.gray600, fontWeight: FontWeight.w200),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
                          prefixStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                          // Change the font weight here
                        ),
                      ),
                    ]),
                  ),
                ),

                //username

                10.heightBox,
                otp.text.fontFamily(light).gray400.make(),

                30.heightBox,

                Obx(
                  () => Visibility(
                    visible: controller.isOtpSent.value,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                6,
                                (index) => SizedBox(
                                    width: 50,
                                    child: TextField(
                                      controller:
                                          controller.otpController[index],
                                      cursorColor: btnColor,
                                      onChanged: (value) {
                                        if (value.length == 1 && index <= 5) {
                                          FocusScope.of(context).nextFocus();
                                        } else if (value.isEmpty && index > 0) {
                                          FocusScope.of(context)
                                              .previousFocus();
                                        }
                                      },
                                      style: const TextStyle(
                                        fontFamily: bold,
                                        color: btnColor,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: bgColor)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: bgColor)),
                                        hintText: "_",
                                      ),
                                    )),
                              )),
                        ),
                        20.heightBox,
                        Image.asset(
                          pending,
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ),
                120.heightBox,

                Container(
                  margin: EdgeInsets.only(bottom: 16),

                  //margin: EdgeInsets.all(16.0),
                  // Adjust margin as needed

                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blColor, // Background color
                        onPrimary: Colors.white,
                        minimumSize: const Size(250.0, 50.0),
                        // Text color
                      ),
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          if (controller.isOtpSent.value == false) {
                            controller.isOtpSent.value = true;
                            await controller.sendOtp();
                          } else {
                            await controller.verifyOtp(context);
                          }
                        }
                      },
                      child: Text(
                        'Continue',
                        style: GoogleFonts.play(fontSize: 15),
                      ),
                    ),
                  ),
                ),

                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
