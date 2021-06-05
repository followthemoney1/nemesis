import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sport_news/ui/widgets/image_picker/image_picker_controller.dart';

class ImagePickerWidget extends GetWidget<ImagePickerController> {
  final Function(String) imageUrl;
  ImagePickerWidget({ @required this.imageUrl}) {
    // final controller =
    
  }
  get controller => Get.find<ImagePickerController>();

  var context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return GetBuilder<ImagePickerController>(
        init: controller,
        builder: (controller) {
          if (controller.imageUrl!=null && controller.imageUrl.isNotEmpty) {
            imageUrl(controller.imageUrl);
          }
          return MaterialButton(
            child: controller.imageUrl == null || controller.imageUrl.isEmpty
                ? Text("Pick Image")
                : Image.network(controller.imageUrl),
            onPressed: () {
              controller.pickImage();
            },
          );
        });
  }
}
