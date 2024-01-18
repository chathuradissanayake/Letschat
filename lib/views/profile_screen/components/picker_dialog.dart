import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letschat_flutter/consts/consts.dart';

Widget pickerDialog(context, controller) {
  var listTitle = [camera, gallery, cancel];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_actual_rounded,
    Icons.cancel_presentation_rounded
  ];

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: EdgeInsets.all(12),
      color: bgColor,
      child: Column(
        //setting to min
        mainAxisSize: MainAxisSize.min,
        children: [
          source.text.fontFamily(semibold).white.make(),
          const Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        //setting ontap according to the index
                        switch (index) {
                          //ontap on camera
                          case 0:
                            Get.back();
                            //providing camera source
                            controller.pickImage(context, ImageSource.camera);
                            break;
                          //ontap on gallary
                          case 1:
                            Get.back();
                            controller.pickImage(context, ImageSource.gallery);
                            break;

                          //ontap on cancel
                          case 2:
                            Get.back();
                            break;
                        }
                      },
                      //getting icons from the list
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),

                      //getting titles from the list
                      title: listTitle[index].text.white.make(),
                    )),
          ),
        ],
      ),
    ),
  );
}
