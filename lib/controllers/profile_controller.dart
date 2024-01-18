import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letschat_flutter/consts/consts.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  //text editing controllers
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  var imgpath = ''.obs;
  var imglink = '';

  //update profile method
  updateProfile(context) async {
    //setting store variable to the document of our current user
    var store =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);

    //lets update the dta now
    store.set({
      'name': nameController.text,
      'about': aboutController.text,
      //phone controller cant be changed
      //update the image url field
      //it will be empty if image is not selected
      'image_url': imglink
    }, SetOptions(merge: true));

    VxToast.show(context, msg: "Profile updated successfully");
  }

  //image picking method
  pickImage(context, source) async {
    //get permission from user
    var storageStatus = await Permission.photos.request();
    var cameraStatus = await Permission.camera.request();
    //await Permission.camera.request();

    //getting state of our permission to handle
    //var status = await Permission.photos.status;

    //handle status
    if (cameraStatus.isGranted || storageStatus.isGranted) {
      //when status is granted
      try {
        //source will be according to user choice
        //picking image and saving in img variable
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 100);

        //setting our variable equal to this image path
        imgpath.value = img!.path;
        VxToast.show(context, msg: "Image Selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(context, msg: "Permission Denied !");
    }
  }

//upload the image to firestorage
  uploadImage() async {
    //getting name of the selected file
    //imprting path.dart for the baseman
    //add the path of selected image
    var name = basename(imgpath.value);
    //setting destination of file on firestorage
    //it will create a path in storage with image folder
    var destination = 'images/${currentUser!.uid}/$name';

    //triggering firestorage to save our file
    //adding the detination to create file
    Reference ref = FirebaseStorage.instance.ref().child(destination);

    //uploading our file
    await ref.putFile(File(imgpath.value));

    //getting url of our uploaded file and saving it into our img link variable
    var d = await ref.getDownloadURL();
    print(d);
    imglink = d;
  }
}
